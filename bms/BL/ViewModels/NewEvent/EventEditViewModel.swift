//
//  NewEventViewModel.swift
//  bms
//
//  Created by Sergey on 23.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class EventEditViewModel: BaseViewModel {
    
    var didLoadData: (() -> Void)?
    var eventCategoryList: [EventCategoryObject]?
    var event: eventDetailObject?
    var didSetPageState: ((EventEditPageState) -> Void)?
    var didDataChange: (() -> Void?)?
    enum EventEditPageState {
        case new
        case edit
        case readOnly
    }
    func didSelectEventType(item: EventCategoryObject) {
        event?.eventCategoryId = item.id
    }
    func didDescriptionTextChange(text: String) {
        event?.reason = text
    }
    func didStartDateChange(date: Date) {
        event?.startDate = date
    }
    func didEndDateChange(date: Date) {
        event?.endDate = date
    }
    func deleteEvent() {
        showLoading()
        DataServices.calendarDataService?.removeEventById(guid: self.event!.id,
                                                          completionHandler: {
                                                            [weak self] in
                                                            self?.navigateBack(mode: .modal)
                                                            self?.hideLoading()
                                                            self?.didDataChange?()
            }, errorHandler: { [weak self] message in
                self?.hideLoading()
                self?.navigateBack(mode: .modal)
                self?.showAlert(message: message)
        })
    }
    func addOrUpdateEvent(onlyStartDate: Bool = true) {
        showLoading()
        if (event?.startDate == event?.endDate || onlyStartDate == true) {
            event?.endDate = nil
        }
        DataServices.calendarDataService?.addOrUpdate(
            event: event!,
            completionHandler: {
                [weak self] in
                self?.hideLoading()
                self?.navigateBack(mode: .modal)
                self?.didDataChange?()
            },
            errorHandler: { [weak self] message in
                self?.navigateBack(mode: .modal)
                self?.showAlert(message: message)
        })
    }
    override func viewDidLoad() {
        showLoading()
        self.didDataChange = navigationParams["didDataChange"] as! () -> Void
        eventCategoryList = DataServices.cachedDataService?.getEventCategoryList()
        let eventId = navigationParams["eventId"] as! String?
        if (eventId == nil || eventId == "") {
            didSetPageState?(.new)
            event = eventDetailObject(id: "",
                                      eventCategoryId: eventCategoryList!.first!.id,
                                      reason: "",
                                      startDate: Date(),
                                      endDate: nil,
                                      status: .created)
            self.didSetPageState?(.new)
            self.didLoadData?()
            self.hideLoading()
        } else {
            DataServices.calendarDataService?
                .getEventDetailObjectById(guid: eventId!,
                                          completionHandler: { [weak self] eventDetailObject in
                                            self?.event = eventDetailObject
                                            let eventStatus = eventDetailObject.status
                                            if (eventStatus == StatusEnum.created) {
                                                self?.didSetPageState?(.edit)
                                            }
                                            if (eventStatus == StatusEnum.approved
                                                || eventStatus == StatusEnum.denied) {
                                                self?.didSetPageState?(.readOnly)
                                            }
                                            self?.didLoadData?()
                                            self?.hideLoading() },
                                          errorHandler: { [weak self] message in
                                            self?.showAlert(message: message)
                                            self?.hideLoading()}
            )
        }
    }
}
