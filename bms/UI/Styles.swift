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
        static let disabledColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        static let accentColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
        static let errorColor = UIColor(red: 255/255, green: 100/255, blue: 100/255, alpha: 1.0)
    }
    
    class Fields {
        private init(){}
        
        static func mainSkyFieldWithImage(view: UIView) {
            guard let skyField = view as? SkyFloatingLabelTextFieldWithIcon else { return }
            skyField.iconType = .image
            skyField.iconColor = Styles.Colors.mainColor
            skyField.iconWidth = 18
            skyField.iconMarginBottom = 0
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
            skyField.errorColor = Styles.Colors.errorColor
            
        }
        
    }
    class UIViews {
        private init(){}
        
        static func shadowUIView(view: UIView){
            view.layer.cornerRadius = 8
            view.layer.shadowColor = UIColor.gray.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 4.0)
            view.layer.shadowOpacity = 0.24
            view.layer.shadowRadius = CGFloat(4.0)
        }
    }
    
    class Buttons {
        private init(){}
        
        static func lightMainButton(view: UIView) {
            guard let button = view as? UIButton else { return }
            mainButton(view: button)
            button.tintColor = Styles.Colors.mainColor
            button.layer.borderColor = Styles.Colors.mainColor.cgColor
            button.backgroundColor = .white
            button.layer.borderWidth = 1
        }
        static func mainButton(view: UIView) {
            guard let button = view as? UIButton else { return }
            button.backgroundColor = Styles.Colors.mainColor
            button.tintColor = .white
            button.layer.cornerRadius = 6
        }
    }
    
    class Labels {
        static func placeholderLabel(view: UIView){
            guard let label = view as? UILabel else { return }
            label.textColor = UIColor.gray
            label.font = .systemFont(ofSize: 13)
        }
        
        static func dayLabel(view: UIView){
            guard let label = view as? UILabel else { return }
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 6
            label.backgroundColor = Colors.mainColor
            label.textColor = .white
        }
    }
    
}

extension UIView{
    func applayStyle(_ style: ((_ button: UIView) -> Void)) {
        style(self)
    }
}

