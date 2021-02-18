//
//  MyBarButton.swift
//  MovieList
//
//  Created by Berkehan on 18.02.2021.
//

import UIKit
class MyBarButtonItem : UIBarButtonItem {
    
    var buttonAction :  (()->())?
    init(buttonIconName: String) {
        super.init()
        setupCustomView()
        setButtonIcon(iconName: buttonIconName)
    }
    
    init(customView: UIView) {
        super.init()
        self.customView = customView
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setNavbarButtonAction(completion : @escaping ()->()){
        self.buttonAction = completion
        if let button = self.customView as? UIButton {
            button.addTarget(self, action: #selector(realAction), for: .touchUpInside)
        } else {
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.realAction))
            self.customView!.addGestureRecognizer(tapGR)
            self.customView!.isUserInteractionEnabled = true
        }
        
    }
    @objc func realAction() {
        self.buttonAction!()
    }
     func setButtonIcon(iconName: String) {
        let button = self.customView as! UIButton
        button.setImage(UIImage(named: iconName), for: .normal)
        self.customView = button
    }
    
    private func setupCustomView() {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.customView = button
        
    }
}

