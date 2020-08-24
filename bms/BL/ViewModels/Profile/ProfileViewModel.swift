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
    var onDataLoaded: ((UserInfoObject?)  -> Void)?
    
    override func viewDidLoad() {
        updateData()
    }
    
    
    func updateData() {
        showLoading()
        DataServices.userDataService?.getUserInfo(completionHandler: { userData in
                            DispatchQueue.main.async {
                                [weak self] in
                                guard let self = self else { return }
                                self.userInfo = userData.convert
                                self.onDataLoaded?(self.userInfo)
                            }
               },
                errorHandler: {
                   message in
                   self.showAlert(title: message)
               })
        
         hideLoading()
    }

}
