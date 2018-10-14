//
//  WeeklyWeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Adam McGrade on 8/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import UIKit

class WeeklyWeatherDetailsViewController: UIViewController, UITableViewDataSource, HasForecastType, HasFavouriteButton, HasActivityIndicator, PresentsErrorMessages {
    
    // MARK: - Outlets
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: - Properties
    
    var activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    var favouriteButton: FavouriteButton = FavouriteButton()
    var favouriteBarButton: UIBarButtonItem?
    var isFavourite: Bool = false
    var location: Location?
    var forecasts = [DetailedForecast]()
    var forecastType: ForecastType = .weekly
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "7 Day Forecast"
        
        guard let location = location else { return }
        
        locationLabel.text = location.city
        
        self.view.addBackground(imageName: "\(location.city)-bg")
        
        // check if the current forecast has been set as favourite
        isFavourite = isForecastSetAsFavourite(currentLocation: location, forecastType: forecastType)
        
        self.setupActivityIndicator()
        activityIndicatorView.startAnimating()
        setupTableView()
        
        WeatherDataController.shared.fetchWeeklyWeather(at: location.coordinates) { (weeklyForecasts) in
            DispatchQueue.main.async {
                if let weeklyForecasts = weeklyForecasts {
                    self.forecasts = weeklyForecasts.daily.data
                    self.tableView.reloadData()
                    self.dismissActivityIndicator()
                    self.tableView.isHidden = false
                } else {
                    self.dismissActivityIndicator()
                    self.presentError()
                }
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
    
    // MARK: - TableView Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.weatherDetailsCell, for: indexPath) as! WeatherDetailsTableViewCell
        let forecast = forecasts[indexPath.row]
        cell.update(with: forecast)
        return cell
    }
    
    func setupTableView() {
        tableView.register((UINib(nibName: "WeatherDetailsTableViewCell", bundle: nil)), forCellReuseIdentifier: TableCellIdentifiers.weatherDetailsCell)
        tableView.backgroundColor = UIColor.clear
        tableView.isHidden = true
    }
    
    // MARK: - UI Setup and Updates
    
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
