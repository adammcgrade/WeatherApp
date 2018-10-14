//
//  CurrentWeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Adam McGrade on 30/7/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import UIKit

class CurrentWeatherDetailsViewController: UIViewController, HasForecastType, HasFavouriteButton, HasActivityIndicator, PresentsErrorMessages {
    
    // MARK: - Outlets
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureSummaryLabel: UILabel!
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
    var forecastType: ForecastType = .current
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {   
        super.viewDidLoad()
        
        self.navigationItem.title = "Current Weather"
        
        guard let location = location else { return }
        
        locationLabel.text = location.city
        
        self.view.addBackground(imageName: "\(location.city)-bg")
        
        // check if the current forecast has been set as favourite
        isFavourite = isForecastSetAsFavourite(currentLocation: location, forecastType: forecastType)
        
        self.setupActivityIndicator()
        activityIndicatorView.startAnimating()
        
        WeatherDataController.shared.fetchCurrentWeather(at: location.coordinates) { (currentWeather) in
            guard let currentWeather = currentWeather else {
                DispatchQueue.main.async {
                    self.dismissActivityIndicator()
                    self.presentError()
                }
                
                return
            }
                
            DispatchQueue.main.async {
                self.updateUI(with: currentWeather)
                self.dismissActivityIndicator()
            }
        }
        
        // setup the favourite button and place in the navigation bar
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
        return .lightContent
    }
    
    // MARK: - UI Setup and Updates

    func updateUI(with weatherInfo: CurrentWeatherData) {
        let temperature = Measurement(value: weatherInfo.forecast.temperature.rounded(), unit: UnitTemperature.celsius)
        let windDirection = Measurement(value: Double(weatherInfo.forecast.windBearing), unit: UnitAngle.degrees)
        let windSpeed = Measurement(value: weatherInfo.forecast.windSpeed, unit: UnitSpeed.kilometersPerHour)
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = MeasurementFormatter.UnitStyle.medium
        // set units to be appropriate for user's locale, e.g. en_US will show farenheit
        formatter.locale = Locale.current
        
        dateLabel.text = weatherInfo.forecast.dateForHumans
        
        temperatureLabel.text = formatter.string(from: temperature)
        temperatureSummaryLabel.text = weatherInfo.forecast.summary
        
        weatherIconImageView.image = weatherInfo.forecast.icon.image.withRenderingMode(.alwaysTemplate)
        weatherIconImageView.tintColor = UIColor.white
        
        windDirectionIconImageView.image = UIImage(named: "wind-direction")?.withRenderingMode(.alwaysTemplate)
        windDirectionIconImageView.tintColor = UIColor.white
        windDirectionLabel.text = formatter.string(from: windDirection)
        
        windSpeedIconImageView.image = UIImage(named: "wind-speed")?.withRenderingMode(.alwaysTemplate)
        windSpeedIconImageView.tintColor = UIColor.white
        windSpeedLabel.text = formatter.string(from: windSpeed)
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
