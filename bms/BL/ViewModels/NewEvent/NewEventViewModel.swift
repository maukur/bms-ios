//
//  NewEventViewModel.swift
//  bms
//
//  Created by Sergey on 23.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class NewEventViewModel: BaseViewModel {
    
    var onEventTypListLoaded: (([EventCategoryObject])  -> Void)?
    var eventTypeList: [EventCategoryObject] = []
    var event: EventDetailObject?


    func didSelectEventType(item: EventCategoryObject) {
        event?.eventCategoryId = item.id
    }

    func addOrUpdateEvent() {
        showLoading()
        DataServices.calendarDataService?.addOrUpdate(
                event: event!,
                completionHandler: {
                    [weak self] in
                    self?.hideLoading()
                    self?.navigateBack(mode: .modal)
                },
                errorHandler: {
                    [weak self] message in
                    self?.navigateBack(mode: .modal)
                    self?.showAlert(message: message)
                })
    }

    override func viewDidLoad() {
        showLoading()


        if(event == nil){
            event = EventDetailObject(id: "",
                    eventCategoryId: "", //TODO
                    reason: "",
                    startDate: Date(),
                    endDate: Date(),
                    status: .created)
        }


        DataServices.calendarDataService?.getEventTypeList(
            completionHandler: { data in
                DispatchQueue.main.async {
                    [weak self] in
                    guard let self = self else { return }
                    self.eventTypeList = data
                    self.onEventTypListLoaded?(self.eventTypeList)
                    self.hideLoading()
                    
                }
        },
            errorHandler: {
                [weak self] message in
                guard let self = self else { return }
                self.hideLoading()
                self.showAlert(title: message)
                
        })
    }
}
