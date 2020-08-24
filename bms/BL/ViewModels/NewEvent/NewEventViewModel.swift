//
//  NewEventViewModel.swift
//  bms
//
//  Created by Sergey on 23.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class NewEventViewModel: BaseViewModel {
    
    var onEventTypListLoaded: (([EventTypeObject])  -> Void)?
    var eventTypeList: [EventTypeObject] = []
    
    override func viewDidLoad() {
        showLoading()
        DataServices.calendarDataService?.getEventTypeList(completionHandler: { data in
                                   DispatchQueue.main.async {
                                       [weak self] in
                                       guard let self = self else { return }
                                       self.eventTypeList = data
                                       self.onEventTypListLoaded?(self.eventTypeList)
                                   }
                      },
                       errorHandler: {
                          message in
                          self.showAlert(title: message)
                      })
               
        hideLoading()
    }
}
