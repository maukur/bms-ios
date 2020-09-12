//
//  EditableProfileView.swift
//  bms
//
//  Created by Sergey on 18.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//


import UIKit
import SkyFloatingLabelTextField

class EditableProfileView: UIView {

    let nibName = "EditableProfileView"
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var textField: SkyFloatingLabelTextField!{
        didSet{
            textField.applayStyle(Styles.Fields.mainSkyField)
        }
    }
    private var inEditing = false
    
    @objc func onIconClicked(sender: Any) {
        inEditing.toggle()
        textField.isUserInteractionEnabled = inEditing
        if inEditing {
            textField.becomeFirstResponder()
            UIView.transition(with: icon,
                                duration: 0.1,
                                options: .transitionCrossDissolve,
                                animations: { self.icon.image = #imageLiteral(resourceName: "accept")},
                                completion: nil)
        }
        else {
            UIView.transition(with: icon,
                                duration: 0.1,
                                options: .transitionCrossDissolve,
                                animations: { self.icon.image = #imageLiteral(resourceName: "pencil") },
                                completion: nil)
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onIconClicked))
        icon.addGestureRecognizer(tapGesture)
        icon.isUserInteractionEnabled = true
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
