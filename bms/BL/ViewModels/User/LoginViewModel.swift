//
//  LoginViewModel.swift
//  OrderKing
//
//  Created by Artem Tischenko on 13.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class LoginViewModel: BaseViewModel {
    
    func loginAction(login: String?, password: String?) {
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
}
