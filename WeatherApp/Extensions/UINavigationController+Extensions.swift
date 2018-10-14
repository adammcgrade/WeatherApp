//
//  UINavigationController+Extensions.swift
//  WeatherApp
//
//  Created by Adam McGrade on 22/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func setTransparent() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 17)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    func restoreToDefaultApperance() {
        self.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationBar.shadowImage = nil
        self.navigationBar.tintColor = UIColor.black
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 17)!,
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
    }
}
