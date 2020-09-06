//
//  ExpensesEditViewModel.swift
//  bms
//
//  Created by Artem Tischenko on 03.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class ExpenseEditViewModel: BaseViewModel {

    var onSetCategories: (([ExpenseCategoryObject]) -> Void)?
    var onSetCurrencies: (([CurrencyObject]) -> Void)?
    var onSetPaymentTypes: (([PaymentTypeObject]) -> Void)?
    var onSetCurrentCategory: ((ExpenseCategoryObject) -> Void)?
    var onSetCurrentCurrency: ((CurrencyObject) -> Void)?
    var onSetCurrentDate: ((Date) -> Void)?
    var onSetCurrentPaymentType: ((PaymentTypeObject) -> Void)?
    var onSetCurrentItem: ((ExpenseDetailObject) -> Void)?
    var didDataChange: (() -> ()?)?
    var didSetPageState: ((expensePageState) -> Void)?

    var item: ExpenseDetailObject?


    func didSelectCategory(item: ExpenseCategoryObject) {
        onSetCurrentCategory?(item)
        self.item?.expenseCategoryId = item.id
    }

    func didSelectCurrency(item: CurrencyObject) {
        onSetCurrentCurrency?(item)
        self.item?.currencyId = item.id
    }

    func deleteItem() {
        showLoading()
        DataServices.expenseDataService?.removeById(guid: item!.id,
                completionHandler: {
                    [weak self] in
                    self?.didDataChange?()
                    self?.navigateBack(mode: .modal)
                },
                errorHandler: {
                    [weak self] message in
                    self?.hideLoading()
                    self?.showAlert(title: message)

                })
    }

    func cancel() {
        navigateBack(mode: .modal)
    }

    func didSelectPaymentType(item: PaymentTypeObject) {
        onSetCurrentPaymentType?(item)
        self.item?.paymentMethodId = item.id

    }

    func didSelectDate(date: Date) {
        onSetCurrentDate?(date)
        self.item?.date = date.toString()

    }

    func didSelectDescription(description: String) {
        item?.description = description
    }

    func didSelectPrice(value: Double) {
        item?.amount = Double(value)
    }

    func save() {
        showLoading()
        DataServices.expenseDataService?.addOrUpdate(expense: item!,
                completionHandler: {
                    [weak self] in
                    self?.hideLoading()
                    self?.didDataChange?()
                    self?.navigateBack(mode: .modal)
                },
                errorHandler: {
                    [weak self] message in
                    self?.showAlert(message: message)
                    self?.hideLoading()
                })
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

        let resultCategories = DataServices.cachedDataService?.getExpenseCategoryList()
        let resultPaymentTypes = DataServices.cachedDataService?.getExpensePaymentList()
        let resultCurrencies = DataServices.cachedDataService?.getExpenseCurrencyList()

        self.onSetPaymentTypes?(resultPaymentTypes!)
        self.onSetCategories?(resultCategories!)
        self.onSetCurrencies?(resultCurrencies!)

        let item = navigationParams["item"] as? ExpenseObject
        self.didDataChange = navigationParams["didDataChange"] as! () -> ()?


        if (item == nil) {
            self.didSetPageState?(.new)
            self.didSelectPaymentType(item: resultPaymentTypes!.first!)
            self.didSelectCurrency(item: resultCurrencies!.first!)
            self.didSelectCategory(item: resultCategories!.first!)
            self.item = ExpenseDetailObject(
                    id: "",
                    description: "",
                    date: Date().toString(.dateTime),
                    amount: 0.0,
                    expenseCategoryId: resultCategories!.first!.id,
                    currencyId: resultCurrencies!.first!.id,
                    paymentMethodId: resultPaymentTypes!.first!.id,
                    image: nil,
                    status: .created)
            self.onSetCurrentItem?(self.item!)
            self.hideLoading()

        } else {
            DataServices.expenseDataService!.getById(guid: item!.id,
                    completionHandler: {
                        result in
                        self.item = result
                        self.onSetCurrentItem?(result)
                        self.didSelectPaymentType(item: resultPaymentTypes!.first(where: { $0.id == result.paymentMethodId })!)
                        self.didSelectCurrency(item: resultCurrencies!.first(where: { $0.id == result.currencyId })!)
                        self.didSelectCategory(item: resultCategories!.first(where: { $0.id == result.expenseCategoryId })!)
                        if result.status != .approved {
                            self.didSetPageState?(.edit) }
                        else {
                            self.didSetPageState?(.readOnly) }
                        self.hideLoading()
                    },
                    errorHandler: {
                        message in
                        self.hideLoading()
                    })
        }


    }
}

enum expensePageState {
    case new
    case edit
    case readOnly
}
