//
//  WeatherDetailsTableViewCell.swift
//  WeatherApp
//
//  Created by Adam McGrade on 30/7/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import UIKit

class WeatherDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherSummaryLabel: UILabel!
    @IBOutlet weak var temperatureHighIconImageView: UIImageView!
    @IBOutlet weak var temperatureHighLabel: UILabel!
    @IBOutlet weak var temperatureLowIconImageView: UIImageView!
    @IBOutlet weak var temperatureLowLabel: UILabel!
    @IBOutlet weak var windDirectionIconImageView: UIImageView!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedIconImageView: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with forecast: DetailedForecast) {
        let temperatureHigh = Measurement(value: forecast.temperatureHigh.rounded(), unit: UnitTemperature.celsius)
        let temperatureLow = Measurement(value: forecast.temperatureLow.rounded(), unit: UnitTemperature.celsius)
        let windDirection = Measurement(value: Double(forecast.windBearing), unit: UnitAngle.degrees)
        let windSpeed = Measurement(value: forecast.windSpeed, unit: UnitSpeed.kilometersPerHour)
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = MeasurementFormatter.UnitStyle.medium
        // set units to be appropriate for user's locale, e.g. en_US will show farenheit
        formatter.locale = Locale.current
        
        dateLabel.text = forecast.dateForHumans
        weatherSummaryLabel.text = forecast.summary
        
        temperatureHighIconImageView.image = UIImage(named: "high-temp")?.withRenderingMode(.alwaysTemplate)
        temperatureHighIconImageView.tintColor = UIColor.white
        temperatureHighLabel.text = formatter.string(from: temperatureHigh)
        
        temperatureLowIconImageView.image = UIImage(named: "low-temp")?.withRenderingMode(.alwaysTemplate)
        temperatureLowIconImageView.tintColor = UIColor.white
        temperatureLowLabel.text = formatter.string(from: temperatureLow)
        
        // Change formatter style to display shortened measurement units
        formatter.unitStyle = MeasurementFormatter.UnitStyle.short
        
        windDirectionIconImageView.image = UIImage(named: "wind-direction")?.withRenderingMode(.alwaysTemplate)
        windDirectionIconImageView.tintColor = UIColor.white
        windDirectionLabel.text = formatter.string(from: windDirection)
        
        windSpeedIconImageView.image = UIImage(named: "wind-speed")?.withRenderingMode(.alwaysTemplate)
        windSpeedIconImageView.tintColor = UIColor.white
        windSpeedLabel.text = formatter.string(from: windSpeed)
        
        weatherIconImageView.image = forecast.icon.image.withRenderingMode(.alwaysTemplate)
        weatherIconImageView.tintColor = UIColor.white
    }
    
}
