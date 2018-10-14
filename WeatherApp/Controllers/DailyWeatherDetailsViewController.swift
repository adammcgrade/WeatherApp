//
//  DailyWeatherViewController.swift
//  WeatherApp
//
//  Created by Adam McGrade on 30/7/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import UIKit

class DailyWeatherDetailsViewController: UIViewController, HasForecastType, HasFavouriteButton, HasActivityIndicator, PresentsErrorMessages {
    
     // MARK: - Outlets
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherSummaryLabel: UILabel!
    @IBOutlet weak var highTemperatureIconImageView: UIImageView!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureIconImageView: UIImageView!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var windDirectionIconImageView: UIImageView!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedIconImageView: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: - Properties
    
    var activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    var favouriteButton: FavouriteButton = FavouriteButton()
    var favouriteBarButton: UIBarButtonItem?
    var isFavourite: Bool = false
    var location: Location?
    var forecastType: ForecastType = .daily
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "24 Hour Forecast"
        
        guard let location = location else { return }
        
        locationLabel.text = location.city
        
        self.view.addBackground(imageName: "\(location.city)-bg")
        
        // check if the current forecast has been set as favourite
        isFavourite = isForecastSetAsFavourite(currentLocation: location, forecastType: forecastType)
        
        self.setupActivityIndicator()
        activityIndicatorView.startAnimating()
        
        WeatherDataController.shared.fetchTodaysWeather(at: location.coordinates) { (todaysWeather) in
            guard let todaysWeather = todaysWeather else {
                DispatchQueue.main.async {
                    self.dismissActivityIndicator()
                    self.presentError()
                }
                return
            }
            
            DispatchQueue.main.async {
                self.updateUI(with: todaysWeather)
                self.dismissActivityIndicator()
            }
        } 
        
        // configure the favourite button
        setupFavouriteButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setTransparent()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        self.navigationController?.restoreToDefaultApperance()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: - UI Setup and Updates
    
    func updateUI(with weatherInfo: WeeklyWeatherData) {
        guard let forecast = weatherInfo.daily.data.first else { return }
        
        let highTemperature = Measurement(value: forecast.temperatureHigh.rounded(), unit: UnitTemperature.celsius)
        let lowTemperature = Measurement(value: forecast.temperatureLow.rounded(), unit: UnitTemperature.celsius)
        let windDirection = Measurement(value: Double(forecast.windBearing), unit: UnitAngle.degrees)
        let windSpeed = Measurement(value: forecast.windSpeed, unit: UnitSpeed.kilometersPerHour)
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = MeasurementFormatter.UnitStyle.medium
        // set units to be appropriate for user's locale, e.g. en_US will show farenheit
        formatter.locale = Locale.current
        
        dateLabel.text = forecast.dateForHumans
        weatherSummaryLabel.text = forecast.summary
        
        highTemperatureIconImageView.image = UIImage(named: "high-temp")?.withRenderingMode(.alwaysTemplate)
        highTemperatureIconImageView.tintColor = UIColor.white
        highTemperatureLabel.text = formatter.string(from: highTemperature)
        
        lowTemperatureIconImageView.image = UIImage(named: "low-temp")?.withRenderingMode(.alwaysTemplate)
        lowTemperatureIconImageView.tintColor = UIColor.white
        lowTemperatureLabel.text = formatter.string(from: lowTemperature)
        
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

    func setupFavouriteButton() {
        favouriteButton.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        favouriteBarButton = UIBarButtonItem(customView: favouriteButton)
        navigationItem.setRightBarButton(favouriteBarButton, animated: false)
        updateFavouriteButton()
    }
    
    func presentError() {
        errorMessageLabel.text = ErrorMessages.failedToFetchDataMessage
        errorMessageLabel.isHidden = false
    }
    
    // MARK: - UI Events
    
    @objc func favouriteButtonPressed(_ sender: UIButton) {
        favouriteBarButton?.customView?.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        self.handleFavouriteButtonPressed {
            guard let location = self.location else { return }
            
            //If favourite exists in plist file, assume user wants to unfavourite so clear the file
            //Otherwise save the favourite to file
            if self.isFavourite {
                FavouritesDataController.shared.clearFavouritesFile()
            } else {
                let favouriteData = Favourite(location: location, forecastType: self.forecastType)
                FavouritesDataController.shared.saveFavouriteToFile(favourite: favouriteData)
            }
            
            self.isFavourite = !self.isFavourite
            self.updateFavouriteButton()
        }
    }
}
