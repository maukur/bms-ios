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
        navigateBack(mode: "modal")
    }
    
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
        
        let item = navigationParams["item"] as?  ExpenseObject
        DataServices.expenseDataService?.getCategories(completionHandler: {
            resultCategories in
            self.onSetCategories?(resultCategories)
            
            DataServices.expenseDataService?.getPaymentTypes(completionHandler: {
                resultPaymentTypes in
                self.onSetPaymentTypes?(resultPaymentTypes)
                DataServices.expenseDataService?.getCurrencies(completionHandler:{
                    resultCurrencies in
                    self.onSetCurrencies?(resultCurrencies)
                    
                    if(item == nil){
                        self.didSelectPaymentType(item: resultPaymentTypes.first!)
                        self.didSelectCurrency(item:  resultCurrencies.first!)
                        self.didSelectCategory(item:  resultCategories.first!)
                        self.item = ExpenseDetailObject(id: "",
                                                        description: "",
                                                        date: Date().toString(.dateTime),
                                                        price: 0,
                                                        status: "",
                                                        categoryId: "",
                                                        currencyId: "",
                                                        paymentTypeId: "",
                                                        image: nil)
                        self.hideLoading()

                    }
                    else {
                        DataServices.expenseDataService!.getById(guid: "b13bc54d-6123-4873-bb49-2eea3503e127",
                                                                 completionHandler: {
                                                                    result in
                                                                    self.item = result
                                                                    self.onSetCurrentItem?(result)
                                                                    self.didSelectPaymentType(item: resultPaymentTypes.first(where: { $0.id == result.paymentTypeId })!)
                                                                    self.didSelectCurrency(item: resultCurrencies.first(where: { $0.id == result.currencyId })!)
                                                                    self.didSelectCategory(item: resultCategories.first(where: { $0.id == result.categoryId })!)
                                                                    self.hideLoading()
                        },
                                                                 errorHandler: {
                                                                    message in
                                                                    self.hideLoading()
                        })
                    }
                }, errorHandler: {
                    result in
                    self.State = "error"
                    self.hideLoading()

                })
                
            }, errorHandler: {
                result in
                self.State = "error"
                self.hideLoading()

            })
            
        }, errorHandler: {
            result in
            self.State = "error"
            self.hideLoading()
        }
        )
        
    }
}
