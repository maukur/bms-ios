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
    var eventCategoryList: [EventCategoryObject]?
    var event: EventDetailObject?


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
        //let resultCurrencies = DataServices.cachedDataService?.getExpenseCurrencyList()
        eventCategoryList = DataServices.cachedDataService?.getEventCategoryList()
        if(event == nil){
            event = EventDetailObject(id: "",
                    eventCategoryId: eventCategoryList!.first!.id,
                    reason: "",
                    startDate: Date(),
                    endDate: Date(),
                    status: .created)
        }
        self.onEventTypListLoaded?(self.eventCategoryList!)
    }
}
