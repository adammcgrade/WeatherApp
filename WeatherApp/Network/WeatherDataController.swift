//
//  WeatherDataController.swift
//  WeatherApp
//
//  Created by Adam McGrade on 6/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import Foundation

struct WeatherDataController {
    private let apiKey = "a0648b6928c4b57eba3310d6bc223487"
    private let baseURL = "https://api.darksky.net/forecast/"
    
    static let shared = WeatherDataController()
    
    /**
     Fetches the current forecast at the instant requested from the DarkSky api
     
     - returns:
     An array of weather data representing the forecast at the time requested.
     
     - parameters:
        - coordinates: The longitude and latitude of the location.
        - completion: The forecast data at the time requested.
     */
    func fetchCurrentWeather(at coordinates: Coordinate, completion: @escaping (CurrentWeatherData?) -> Void) {
        let currentWeatherBaseUrl = URL(string: "\(baseURL)\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)")!
        let query: [String: String] = [
            "exclude": "minutely,hourly,daily,alerts,flags",
            "units": "ca"
        ]
        
        guard let url = currentWeatherBaseUrl.withQueries(query) else {
            print("Error: unable to create url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: There was an error with the request: ", error)
            }
            
            guard let data = data else {
                print("Error: Did not recieve any data.")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let currentForecast = try jsonDecoder.decode(CurrentWeatherData.self, from: data)
                completion(currentForecast)
            } catch let error {
                print("Unable to encode data: ", error)
                completion(nil)
            }
        }
        task.resume()
    }
    
    /**
     Fetches the 24 hour forecast for the date provided from the DarkSky api
     
     - returns:
     An array of weather data representing the 24 hour forecast for the timestamp provided.
     
     - parameters:
        - coordinates: The longitude and latitude of the location.
        - completion: The 24 hour forecast data for the timestamp requested.
     */
    func fetchTodaysWeather(at coordinates: Coordinate, completion: @escaping (WeeklyWeatherData?) -> Void) {
        let unixTimestamp = Int(Date().timeIntervalSince1970)
        let todaysWeatherBaseURL = URL(string: "\(baseURL)\(apiKey)/\(coordinates.latitude),\(coordinates.longitude),\(unixTimestamp)")!
        let query: [String: String] = [
            "exclude": "currently,hourly,flags",
            "units": "ca"
        ]
        
        guard let url = todaysWeatherBaseURL.withQueries(query) else {
            print("Unable to generate url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: There was an error with the request: ", error)
            }
            
            guard let data = data else {
                print("Error: Did not recieve any data.")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let dailyForecast = try jsonDecoder.decode(WeeklyWeatherData.self, from: data)
                completion(dailyForecast)
            } catch let error {
                print("Unable to encode data: ", error)
                completion(nil)
            }
        }
        task.resume()
    }
    
    /**
     Fetches the forecast data for a week from the day requested, provided from the DarkSky api
     
     - returns:
     An array of weather data representing the forecast data for 7 days from the day requested.
     
     - parameters:
        - coordinates: The longitude and latitude of the location.
        - completion: The 7 day forecast data for the timestamp requested.
     */
    func fetchWeeklyWeather(at coordinates: Coordinate, completion: @escaping (WeeklyWeatherData?) -> Void) {
        let weeklyWeatherBaseURL = URL(string: "\(baseURL)\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)")!
        let query: [String: String] = [
            "exclude": "alerts,currently,minutely,hourly,flags",
            "units": "ca"
        ]
        
        guard let url = weeklyWeatherBaseURL.withQueries(query) else {
            print("Unable to generate url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: There was an error with the request: ", error)
            }
            
            guard let data = data else {
                print("Error: Did not receive any data.")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let weeklyForecast = try jsonDecoder.decode(WeeklyWeatherData.self, from: data)
                completion(weeklyForecast)
            } catch let error {
                print("Unable to encode data: ", error)
                completion(nil)
            }
        }
        task.resume()
    }
}
