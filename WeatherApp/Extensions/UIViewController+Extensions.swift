//
//  UIViewController.swift
//  WeatherApp
//
//  Created by Adam McGrade on 8/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import Foundation
import UIKit

// MARK: - HasForecastType
/** Defines the forecast type that the view controller is displaying the data for. */

protocol HasForecastType {
    var forecastType: ForecastType { get set }
}

// MARK: - HasFavouriteButton
/** Implements logic for adding and handling the favourite button in a view controller */

protocol HasFavouriteButton {
    var isFavourite: Bool { get set }
    var favouriteButton: FavouriteButton { get set }
    var favouriteBarButton: UIBarButtonItem? { get set }
    func updateFavouriteButton()
    func isForecastSetAsFavourite(currentLocation location: Location, forecastType: ForecastType) -> Bool
}

extension HasFavouriteButton where Self: UIViewController {
    
    /** Handles the logic that switches the icon of the favourite button from the empty heart to filled in heart. */
    func updateFavouriteButton() {
        if let button = favouriteBarButton?.customView as? UIButton {
            let image = isFavourite ?
                UIImage(named: "ios-heart")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate) :
                UIImage(named: "ios-heart-empty")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            button.setImage(image, for: .normal)
        }
    }
    
    /** Checks to see if the user the current location matches the user's favourite location. */
    func isForecastSetAsFavourite(currentLocation location: Location, forecastType: ForecastType) -> Bool {
        guard let favourite = FavouritesDataController.shared.loadFavouriteFromFile() else { return false }
        return (favourite.location == location) && (favourite.forecastType == forecastType)
    }
    
    /** Animates the favourite button on pressed and then runs the completion block that is passed in as an argument. */
    func handleFavouriteButtonPressed(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 10,
                       options: .curveEaseInOut,
                       animations: {
                        self.favouriteBarButton?.customView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                        self.favouriteBarButton?.customView?.transform = CGAffineTransform.identity
        }, completion: { (_) in
            completion()
        })
    }
}

// MARK: - HasActivityIndicator
/** Displays an activity indicator on the view controller when async data is loading */

protocol HasActivityIndicator {
    var activityIndicatorView: UIActivityIndicatorView { get set }
}

extension HasActivityIndicator where Self: UIViewController {
    func setupActivityIndicator() {
        self.activityIndicatorView.color = UIColor.white
        self.view.addSubview(activityIndicatorView)
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func dismissActivityIndicator() {
        self.activityIndicatorView.stopAnimating()
    }
}

// MARK: - PresentsErrorMessages

protocol PresentsErrorMessages {
    func presentError()
}

