//
//  ProfileViewModel.swift
//  bms
//
//  Created by Sergey on 13.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class ProfileViewModel: BaseViewModel {
    
    var userInfo: UserInfoObject?
    var onDataLoaded: ((UserInfoObject?) -> Void)?
    
    func exit() {
        SettingsService.instance.token = ""
        self.navigateTo(modules: ["Login"], mode: .root)
    }
    
    func didPhoneChange(newPhone: String) {
        userInfo?.phone = newPhone
    }
    
    func updateUserInfo() {
        showLoading()
        DataServices.userDataService?.updateUserInfo(
            userInfoForUpdate: UserInfoForUpdateObject(fullName: userInfo!.fullName,
                                                       birthDate: userInfo!.birthDate,
                                                       phone: userInfo!.phone),
            completionHandler: { [weak self] in
                self?.hideLoading()
            },
            errorHandler: { [weak self] message in
                self?.hideLoading()
                self?.showAlert(message: message)
        })
    }
    
    override func viewDidLoad() {
        updateData()
    }
    
    func updateData() {
        showLoading()
        DataServices.userDataService?.getUserInfo(
            completionHandler: { userData in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.userInfo = userData
                    self.onDataLoaded?(self.userInfo)
                    self.hideLoading()
                }
        },
            errorHandler: { [weak self] message in
                guard let self = self else { return }
                self.showAlert(title: message)
                self.hideLoading()
        })
    }
}
