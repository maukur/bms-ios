//
//  Styles.swift
//  bms
//
//  Created by Artem Tischenko on 11.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class Styles {
    private init(){}
    
    static let colors = Colors.instance
    
    
    class Colors {
        private init(){}
        fileprivate static let instance = Colors()

        let navBarColor = UIColor(red: 0.0013262250000000001, green: 0.76387274270000005, blue: 0.82405644659999999, alpha: 1)
        let mainColor = UIColor(red: 0.38310644030000002, green: 0.78301173449999995, blue: 0.83530688289999999, alpha: 1)
     }
}
