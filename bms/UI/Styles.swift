//
//  Styles.swift
//  bms
//
//  Created by Artem Tischenko on 11.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class Styles {
    private init(){}
    
    
    class Colors {
        private init(){}
        
        static let navBarColor = UIColor(red: 0.0013262250000000001, green: 0.76387274270000005, blue: 0.82405644659999999, alpha: 1)
        static let mainColor = UIColor(red: 0.38310644030000002, green: 0.78301173449999995, blue: 0.83530688289999999, alpha: 1)
        static let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
        static let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
        static let disabledColor = UIColor(red: 0.65, green: 0.66, blue: 0.66, alpha: 1.0)

    }
    class Fields {
        private init(){}
        
        static func mainSkyFieldWithImage(view: UIView) {
            guard let skyField = view as? SkyFloatingLabelTextFieldWithIcon else { return }
            skyField.iconType = .image
            skyField.iconColor = Styles.Colors.mainColor
            mainSkyField(view: skyField)
        }
        static func mainSkyField(view: UIView) {
            guard let skyField = view as? SkyFloatingLabelTextField else { return }
            skyField.tintColor = Styles.Colors.mainColor
            skyField.textColor = Styles.Colors.darkGreyColor
            skyField.lineColor = Styles.Colors.lightGreyColor
            skyField.selectedTitleColor = Styles.Colors.mainColor
            skyField.selectedLineColor = Styles.Colors.mainColor
            skyField.disabledColor = Styles.Colors.disabledColor
        }
        
    }
    class UIViews {
        private init(){}
        
        static func shadowUIView(view: UIView){
            view.layer.cornerRadius = 8
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 8.0)
            view.layer.shadowOpacity = 0.24
            view.layer.shadowRadius = CGFloat(8.0)
        }
    }
    
    class Buttons {
        private init(){}
        
        
        static func mainButton(view: UIView) {
            guard let button = view as? UIButton else { return }
            button.backgroundColor = Styles.Colors.mainColor
            button.tintColor = .white
            button.layer.cornerRadius = 8
        }
    }
    
}

extension UIView{
    func applayStyle(_ style: ((_ button: UIView) -> Void)) {
        style(self)
    }
}

