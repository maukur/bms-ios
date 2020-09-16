//
//  CalendarViewModel.swift
//  bms
//
//  Created by Artem Tischenko on 12.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class CalendarViewModel: BaseViewModel {
    
    var onSetEvents: (() -> Void)?
    var onSetEventsByDate: (() -> Void)?
    var allEvents: [Date] = []
    var events: [EventObject] = []
    var selectedDate = Date()
    func addNewItem(dates: [Date]) {
        navigateTo(modules: ["EventEdit"], mode: .modalNavigation, navigationParams: ["didDataChange": {[weak self] in
            self?.loadData()
            self?.didSelectDate(date: self!.selectedDate)}])
    }
    func didSelectItem(item: Any) {
        let eventId = (item as? EventObject)!.id
        navigateTo(modules: ["EventEdit"],
                   mode: .modalNavigation,
                   navigationParams: ["eventId": eventId,
                                      "didDataChange": {[weak self] in
                                        self?.loadData()
                                        self?.didSelectDate(date: self!.selectedDate)}])
    }
    func didSelectDate(date: Date) {
        selectedDate = date
        showLoading()
        DataServices.calendarDataService?.getEventsByDate(date: date,
                                                          completionHandler: { [weak self] eventDetailObjects in
                                                            self?.events = eventDetailObjects
                                                            self?.hideLoading()
                                                            self?.onSetEventsByDate?()},
                                                          errorHandler: { [weak self] message in
                                                            self?.hideLoading()
                                                            self?.showAlert(message: message)}
        )
    }
    override func loadData() {
        DataServices.calendarDataService?.getAllEvents(year: 2020,
                                                       completionHandler: { [weak self] events in
                                                        guard let self = self else { return }
                                                        self.allEvents = events
                                                        self.onSetEvents?()
                                                        self.state = "normal" },
                                                       errorHandler: { [weak self] _ in
                                                        self?.state = "error"
        })
    }
}
