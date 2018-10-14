//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Adam McGrade on 7/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import Foundation

protocol WeatherData: Decodable {
    var latitude: Double { get }
    var longitude: Double { get }
    var timezone: String { get }
}

struct CurrentWeatherData: WeatherData {
    var longitude: Double
    var latitude: Double
    var timezone: String
    var forecast: SimpleForecast
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case timezone
        case forecast = "currently"
    }
}

struct WeeklyWeatherData: WeatherData {
    var latitude: Double
    var longitude: Double
    var timezone: String
    var daily: DailyForecasts
}
