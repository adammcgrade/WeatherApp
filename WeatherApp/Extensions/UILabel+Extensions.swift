//
//  UILabel+Extensions.swift
//  WeatherApp
//
//  Created by Adam McGrade on 21/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.masksToBounds = false
    }
}
