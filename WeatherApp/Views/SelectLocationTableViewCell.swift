//
//  SelectLocationTableViewCell.swift
//  WeatherApp
//
//  Created by Adam McGrade on 21/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import UIKit

class SelectLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with location: Location) {
        backgroundImageView.image = UIImage(named: location.city)
        self.titleLabel.text = location.city
        self.subtitleLabel.text = location.country
        self.titleLabel.addShadow()
        self.subtitleLabel.addShadow()
    }
    
}
