//
//  LoginViewModel.swift
//  OrderKing
//
//  Created by Artem Tischenko on 13.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class LoginViewModel: BaseViewModel
{
    func loginAction(login: String?, password: String?) {

        DataServices.userDataService?.login(login: "artem.tischenko@binwell.com", password: "17443821", completionHandler: {
            [weak self] result in
            
         
                let userInfo = result
                SettingsService.instance.token = result.token
                self?.navigateTo(modules:["Expenses", "Calendar","Profile"], mode: "tab")

            
            
            }, errorHandler:   {
                message in
            })
    }
}
