//
//  FavouritesDataController.swift
//  WeatherApp
//
//  Created by Adam McGrade on 8/8/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import Foundation

struct FavouritesDataController {
    static let shared = FavouritesDataController()
    private let archiveURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("favourites").appendingPathExtension("plist")
    
    /**
     Saves a favourite to storage in a plist file.
     - parameters:
        - favourite:
        A favourite object representing the forecast and location the user has chosen to favourite.
     */
    func saveFavouriteToFile(favourite: Favourite) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedFavourite = try? propertyListEncoder.encode(favourite)
        
        do {
            try encodedFavourite?.write(to: archiveURL, options: .noFileProtection)
        } catch let error {
            print("Unable to save favourite to file: ", error)
        }
    }
    
    /**
     Loads a favourite from the plist file.
     - returns:
        Returns a Favourite object representing the forecast and location the user has chosen to favourite.
     */
    func loadFavouriteFromFile() -> Favourite? {
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedFavourite = try? Data(contentsOf: archiveURL) else { return nil }
        return try? propertyListDecoder.decode(Favourite.self, from: retrievedFavourite)
    }
    
    /**
     Clears the user's store favourites from the plist file.
     */
    func clearFavouritesFile() {
        var retrievedFavourite: Data
        
        guard let data = try? Data(contentsOf: archiveURL) else { return }
        
        retrievedFavourite = data
        retrievedFavourite.removeAll()
        
        do {
          try retrievedFavourite.write(to: archiveURL)
        } catch let error {
            print("Unable to clear favourites file: ", error)
        }
        
    }
}
