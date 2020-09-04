//
//  ExpensesEditViewModel.swift
//  bms
//
//  Created by Artem Tischenko on 03.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class ExpenseEditViewModel: BaseViewModel {
    
    var onSetCategories: (([ExpenseCategoryObject])  -> Void)?
    var onSetCurrencies: (([CurrencyObject])  -> Void)?
    var onSetPaymentTypes: (([PaymentTypeObject])  -> Void)?
    
    var onSetCurrentCategory: ((ExpenseCategoryObject) -> Void)?
    var onSetCurrentCurrency: ((CurrencyObject) -> Void)?
    var onSetCurrentDate: ((Date)  -> Void)?
    var onSetCurrentPaymentType: ((PaymentTypeObject)  -> Void)?
    var onSetCurrentItem: ((ExpenseDetailObject) -> Void)?
    
    
    var item:ExpenseDetailObject?
    
    
    func didSelectCategory(item:ExpenseCategoryObject)  {
        onSetCurrentCategory?(item)
        self.item?.categoryId = item.id
    }
    
    func didSelectCurrency(item:CurrencyObject)  {
        onSetCurrentCurrency?(item)
        self.item?.currencyId = item.id
    }
    
    func deleteItem() {
        showLoading()
        
    }
    func cancel() {
        navigateBack(mode: "modal")
    }
    
    func didSelectPaymentType(item:PaymentTypeObject)  {
        onSetCurrentPaymentType?(item)
        self.item?.paymentTypeId = item.id
        
    }
    
    func didSelectDate(date:Date)  {
        onSetCurrentDate?(date)
        self.item?.date = date.toString()
        
    }
    
    func didSelectDescription(description:String)  {
        item?.description = description
    }
    
    func didSelectPrice(value:Int)  {
        item?.price = Int(value)
    }
    
    func save() {
        showLoading()
        DataServices.expenseDataService?.update(expense: item!,
                                                completionHandler: {
                                                    [weak self] in
                                                    self?.hideLoading()
                                                    self?.navigateBack(mode: "modal")
            },
                                                errorHandler: {
                                                    [weak self] message in
                                                    self?.hideLoading()
        })    }
    
    func getPhotoFromGallery() {
        DispatchQueue.global().async {
            let image = self.pickImage(sourceType: .photoLibrary)
            self.item?.image = image?.jpegData(compressionQuality: 1.0)
        }
    }
    
    func getPhotoFromCamera() {
        DispatchQueue.global().async {
            let image = self.pickImage(sourceType: .camera)
            self.item?.image = image?.jpegData(compressionQuality: 1.0)
        }
    }
    
    override func loadData() {
        showLoading()
        
        let resultCategories = DataServices.cachedDataService?.getExpenseCategoryList()
        let resultPaymentTypes = DataServices.cachedDataService?.getExpensePaymentList()
        let resultCurrencies = DataServices.cachedDataService?.getExpenseCurrnecyList()
        
        self.onSetPaymentTypes?(resultPaymentTypes!)
        self.onSetCategories?(resultCategories!)
        self.onSetCurrencies?(resultCurrencies!)
        
        let item = navigationParams["item"] as?  ExpenseObject
        
        
        if(item == nil){
            self.didSelectPaymentType(item: resultPaymentTypes!.first!)
            self.didSelectCurrency(item:  resultCurrencies!.first!)
            self.didSelectCategory(item:  resultCategories!.first!)
            self.item = ExpenseDetailObject(id: "",
                                            description: "",
                                            date: Date().toString(.dateTime),
                                            price: 0,
                                            status: "fe399ac8-63e5-460d-ba10-60948fb9fd27",
                                            categoryId: resultCategories!.first!.id,
                                            currencyId: resultCurrencies!.first!.id,
                                            paymentTypeId: resultPaymentTypes!.first!.id,
                                            image: nil)
            self.onSetCurrentItem?(self.item!)
            self.hideLoading()
            
        }
        else {
            DataServices.expenseDataService!.getById(guid: item!.id,
                                                     completionHandler: {
                                                        result in
                                                        self.item = result
                                                        self.onSetCurrentItem?(result)
                                                        self.didSelectPaymentType(item: resultPaymentTypes!.first(where: { $0.id == result.paymentTypeId })!)
                                                        self.didSelectCurrency(item: resultCurrencies!.first(where: { $0.id == result.currencyId })!)
                                                        self.didSelectCategory(item: resultCategories!.first(where: { $0.id == result.categoryId })!)
                                                        self.hideLoading()
            },
                                                     errorHandler: {
                                                        message in
                                                        self.hideLoading()
            })
        }
        
        
        
    }
}
