//
//  LoadingView.swift
//  bms
//
//  Created by Artem Tischenko on 27.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit


class LoadingView: UIView {
    
 
    @IBOutlet weak var indicator: UIActivityIndicatorView! {
          didSet {
            indicator.color = .red
            indicator.startAnimating()
            indicator.translatesAutoresizingMaskIntoConstraints = false
          }
      }
    
}
