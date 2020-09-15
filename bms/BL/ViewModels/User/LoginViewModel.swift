//
//  LoginViewModel.swift
//  OrderKing
//
//  Created by Artem Tischenko on 13.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class LoginViewModel: BaseViewModel {
    
    var setErrorStateForEmailField: (() -> Void)?
    var setErrorStateForPasswordField: (() -> Void)?
    
    func loginAction(login: String?, password: String?) {
        if(!checkUserCredits(email: login, password: password)) { return }
        showLoading()
        DataServices.userDataService?.login(login: login!, password: password!,
                completionHandler: {
                    [weak self] result in
                    SettingsService.instance.token = result.token
                    self?.hideLoading()
                    self?.navigateTo(modules: ["Expenses", "Calendar", "Profile"], mode: .tab)
                },
                errorHandler: {
                    [weak self] message in
                    self?.hideLoading()
                    self?.showAlert(message: message)
                })
    }
    
    func checkUserCredits(email: String?, password: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidEmail = emailPred.evaluate(with: email)
        let isValidPassword = password?.count ?? 0 >= 6 ? true : false
        if(!isValidEmail) {
            setErrorStateForEmailField?()
        }
        if(!isValidPassword) {
            setErrorStateForPasswordField?()
        }
        if(!isValidEmail || !isValidPassword) {
            return false
        }
        return true
    }
}
