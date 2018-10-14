//
//  URL.swift
//  WeatherApp
//
//  Created by Adam McGrade on 6/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
