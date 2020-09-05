
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
    var dictionary:Dictionary<AnyHashable, [Any]> = [:]
    
    override func loadData() {
        dictionary = [:]
        onDateUpdate?(date)
        let year = date.get(.year)
        showLoading()
        DataServices.expenseDataService?.getAll(year: year, completionHandler: {
            [weak self] items in
            guard let self = self else { return }
            
            let monthSet = Set(items.map(
            {
                value in (value.date.get(.month))
            }))
            
            monthSet.forEach(
                {
                    [weak self] value in
                    guard let self = self else { return }
                    self.dictionary[value] = items.filter({
                        $0.date.get(.month) == value
                    })
            })
            
            DispatchQueue.main.async {
                [weak self] in
                guard let self = self else { return }
                self.data = self.dictionary
                self.onDataUpdate?(self.data)
                self.hideLoading()
            }},
            errorHandler: {
                [weak self] message in
                guard let self = self else { return }
                self.hideLoading()
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

