
//
//   ExpensesViewModel.swift
//  bms
//
//  Created by Artem Tischenko on 14.07.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class ExpensesViewModel: BaseViewModel {
    
    var date: Date = Date()
    var data: Dictionary<AnyHashable, [Any]> = [:]
    
    var onDateUpdate: ((Date)  -> Void)?
    var onDataUpdate: ((Dictionary<AnyHashable, [Any]>)  -> Void)?
    
    
    func goToTheNextYear() {
        date = changeYear(year: 1)
        onDateUpdate?(date)
        loadData()
    }
    func goToThePreviousYear() {
        date = changeYear(year: -1)
        onDateUpdate?(date)
        loadData()
    }
    
    func changeYear(year:Int) -> Date{
        var dateComponent = DateComponents()
        dateComponent.year = year
        return Calendar.current.date(byAdding: dateComponent, to: date) ?? date
    }
    override func loadData() {
          DataServices.expenseDataService?.getAll(year: 2012, completionHandler: { items in
                      
                          var dictionary:Dictionary<AnyHashable, [Any]> = [:]
                      
                          items.forEach({ group in
                              dictionary[group.mounth] = group.expenses
                          })
                          
                          DispatchQueue.main.async {
                              [weak self] in
                              guard let self = self else { return }
                              self.data = dictionary
                              self.onDataUpdate?(self.data)
                              self.hideLoading()
                          }
                      
              },
               errorHandler: {
                  message in
                  self.showAlert(title: message)
              })
    }
     
        
  
    
    func editItem(value:Any){
        let item = value as! ExpenseObject
        navigateTo(modules: ["ExpenseEdit"], mode: "modalNavigation", navigationParams: ["item": item])
    }
    
    func addNewItem(){
        navigateTo(modules: ["ExpenseEdit"], mode: "modalNavigation")
    }
}

