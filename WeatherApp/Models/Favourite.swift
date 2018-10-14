//
//  Favourite.swift
//  WeatherApp
//
//  Created by Adam McGrade on 8/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import Foundation

struct Favourite: Codable {
    let location: Location
    let forecastType: ForecastType
}
