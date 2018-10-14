//
//  Location.swift
//  WeatherApp
//
//  Created by Adam McGrade on 3/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import Foundation

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

extension Coordinate: Equatable {
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct Location: Codable {
    let city: String
    let country: String
    let coordinates: Coordinate
    
    static func all() -> [Location] {
        return [
            Location(city: "Alaska", country: "USA", coordinates: Coordinate(latitude: 66.160507, longitude: -153.369141)),
            Location(city: "Amsterdam", country: "Netherlands", coordinates: Coordinate(latitude: 52.377956, longitude: 4.897070)),
            Location(city: "Athens", country: "Greece", coordinates: Coordinate(latitude: 37.983810, longitude: 23.727539)),
            Location(city: "Auckland", country: "New Zealand", coordinates: Coordinate(latitude: -36.848461, longitude: 174.763336)),
            Location(city: "Beijing", country: "China", coordinates: Coordinate(latitude: 39.913818, longitude: 116.363625)),
            Location(city: "Buenos Aires", country: "Argentina", coordinates: Coordinate(latitude: -34.603722, longitude: -58.381592)),
            Location(city: "Cairo", country: "Egypt", coordinates: Coordinate(latitude: 30.045916, longitude: 31.224291)),
            Location(city: "Dublin", country: "Ireland", coordinates: Coordinate(latitude: 53.350140, longitude: -6.266155)),
            Location(city: "Johannesburg", country: "South Africa", coordinates: Coordinate(latitude: -26.195246, longitude: 28.034088)),
            Location(city: "London", country: "England", coordinates: Coordinate(latitude: 51.509865, longitude: -0.118092)),
            Location(city: "Madrid", country: "Spain", coordinates: Coordinate(latitude: 40.416775, longitude: -3.703790)),
            Location(city: "Melbourne", country: "Australia", coordinates: Coordinate(latitude: -37.819954, longitude: 144.983398)),
            Location(city: "Mexico City", country: "Mexico", coordinates: Coordinate(latitude: 19.432608, longitude: -99.133209)),
            Location(city: "New York", country: "USA", coordinates: Coordinate(latitude: 40.730610, longitude: -73.935242)),
            Location(city: "Paris", country: "France", coordinates: Coordinate(latitude: 48.864716, longitude: 2.349014)),
            Location(city: "Perth", country: "Australia", coordinates: Coordinate(latitude: -31.953512, longitude: 115.857048)),
            Location(city: "Rio de Janeiro", country: "Brazil", coordinates: Coordinate(latitude: -22.970722, longitude: -43.182365)),
            Location(city: "Rome", country: "Italy", coordinates: Coordinate(latitude: 41.902782, longitude: 12.496366)),
            Location(city: "Tokyo", country: "Japan", coordinates: Coordinate(latitude: 35.652832, longitude: 139.839478)),
            Location(city: "Singapore", country: "Singapore", coordinates: Coordinate(latitude: 1.290270, longitude: 103.851959)),
        ]
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.coordinates == rhs.coordinates && lhs.city == rhs.city && lhs.country == rhs.country
    }
}
