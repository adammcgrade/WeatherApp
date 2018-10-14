//
//  FavouriteButton.swift
//  WeatherApp
//
//  Created by Adam McGrade on 14/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import UIKit

class FavouriteButton: UIButton {
    override func awakeFromNib() {
        self.setImage(UIImage(named: "ios-heart-empty")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        self.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    }
}
