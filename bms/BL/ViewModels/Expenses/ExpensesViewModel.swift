
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
        updateData()
    }
    func goToThePreviousYear() {
        date = changeYear(year: -1)
        onDateUpdate?(date)
        updateData()
    }
    
    func changeYear(year:Int) -> Date{
        var dateComponent = DateComponents()
        dateComponent.year = year
        return Calendar.current.date(byAdding: dateComponent, to: date) ?? date
    }
    
    func updateData() {
        showLoading()
        DispatchQueue.global().async {
            [weak self]  in
            guard let self = self else { return }
            let result = DataServices.expenseDataService?.getAll(token: "", year:self.date.get(.year))
            if(result!.isValid()){
                var dictionary:Dictionary<AnyHashable, [Any]> = [:]
                result?.data?.forEach({ group in
                    dictionary[group.mounth] = group.expenses
                })
                
                DispatchQueue.main.async {
                    [weak self] in
                    guard let self = self else { return }
                    self.data = dictionary
                    self.onDataUpdate?(self.data)
                    self.hideLoading()
                }
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        onDateUpdate?(date)
        updateData()
    }
    
    func editItem(value:Any){
        let item = value as! ExpenseObject
        navigateTo(modules: ["ExpenseEdit"], mode: "modal", navigationParams: ["item": item])
    }
    
    func addNewItem(){
        navigateTo(modules: ["ExpenseEdit"], mode: "modal")
    }
}

