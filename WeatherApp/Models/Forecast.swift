//
//  Forecast.swift
//  WeatherApp
//
//  Created by Adam McGrade on 3/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import Foundation
import UIKit

enum ForecastType: String, Codable {
    case current
    case daily
    case weekly
}

enum WeatherIcon: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain = "rain"
    case snow = "snow"
    case sleet = "sleet"
    case wind = "wind"
    case fog = "fog"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case `default` = "default"
}

extension WeatherIcon {
    var image: UIImage {
        switch self {
        case .clearDay: return #imageLiteral(resourceName: "clear-day")
        case .clearNight: return #imageLiteral(resourceName: "clear-night")
        case .rain: return #imageLiteral(resourceName: "rain")
        case .snow: return #imageLiteral(resourceName: "snow")
        case .sleet: return #imageLiteral(resourceName: "sleet")
        case .wind: return #imageLiteral(resourceName: "wind")
        case .fog: return #imageLiteral(resourceName: "fog")
        case .cloudy: return #imageLiteral(resourceName: "cloudy")
        case .partlyCloudyDay: return #imageLiteral(resourceName: "partly-cloudy-day")
        case .partlyCloudyNight: return #imageLiteral(resourceName: "partly-cloudy-night")
        case .default: return UIImage()
        }
    }
}


protocol Forecast: Decodable {
    var time: Int { get }
    var summary: String { get }
    var icon: WeatherIcon { get }
    var windSpeed: Double { get }
    var windBearing: Int { get }
}

struct SimpleForecast: Forecast {
    var time: Int
    var summary: String
    var icon: WeatherIcon
    var temperature: Double
    var windSpeed: Double
    var windBearing: Int
}

struct DetailedForecast: Forecast {
    var time: Int
    var summary: String
    var icon: WeatherIcon
    var temperatureHigh: Double
    var temperatureLow: Double
    var windSpeed: Double
    var windBearing: Int
}

extension Forecast {
    var dateForHumans: String {
        let date = Date(timeIntervalSince1970: Double(self.time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMMM d"
        return dateFormatter.string(from: date)
    }
}

struct DailyForecasts: Decodable {
    var data: [DetailedForecast]
}


