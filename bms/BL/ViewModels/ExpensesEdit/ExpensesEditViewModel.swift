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
    
    
    
    override func viewDidLoad() {
        
        let item = navigationParams["item"] as?  ExpenseObject
        
//        let categoriesListResponse = DataServices.expenseDataService?.getCategories()
//        let paymentTypeListResponse = DataServices.expenseDataService?.getPaymentTypes()
//        let currenciesListResponse = DataServices.expenseDataService?.getCurrencies()
//        
//        onSetCategories?(categoriesListResponse!.data!)
//        onSetCurrencies?(currenciesListResponse!.data!)
//        onSetPaymentTypes?(paymentTypeListResponse!.data!)
//        
//        var paymentType:PaymentTypeObject? = nil
//        var currency:CurrencyObject? = nil
//        var category:ExpenseCategoryObject? = nil
//        
//        if(item == nil){
//            paymentType = paymentTypeListResponse?.data!.first!
//            currency = currenciesListResponse?.data!.first!
//            category = categoriesListResponse?.data!.first!
//            
//            self.item = ExpenseDetailObject(id: "",
//                                            description: "",
//                                            date: Date().toString(.dateTime),
//                                            price: 0,
//                                            status: "",
//                                            categoryId: category!.id,
//                                            currencyId: currency!.id,
//                                            paymentTypeId: paymentType!.id,
//                                            image: nil)
//            onSetCurrentItem?(self.item!)
//            onSetCurrentPaymentType?(paymentType!)
//            onSetCurrentCategory?(category!)
//            onSetCurrentCurrency?(currency!)
//        }
//        else {
//            DispatchQueue.global().async {
//                
//                self.showLoading()
//                let result = DataServices.expenseDataService!.getById(guid: "b13bc54d-6123-4873-bb49-2eea3503e127")
//                
//                paymentType = paymentTypeListResponse?.data!.first(where: { $0.id == result.data!.paymentTypeId })
//                currency = currenciesListResponse?.data!.first(where: { $0.id == result.data!.currencyId })
//                category = categoriesListResponse?.data!.first(where: { $0.id == result.data!.categoryId })
//                
//                DispatchQueue.main.async {
//                    self.item = result.data!
//                    self.onSetCurrentItem?(result.data!)
//                    self.onSetCurrentPaymentType?(paymentType!)
//                    self.onSetCurrentCategory?(category!)
//                    self.onSetCurrentCurrency?(currency!)
//                }
//                
//                self.hideLoading()
//                
//            }
//        }
//        
        super.viewDidLoad()
        
    }
}
