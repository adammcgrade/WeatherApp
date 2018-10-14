//
//  SelectForceastTableViewController.swift
//  WeatherApp
//
//  Created by Adam McGrade on 30/7/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import UIKit

class SelectForceastTableViewController: UITableViewController {
    
    var location: Location?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        guard let location = location else { return }
        
        if segue.identifier == SegueIdentifiers.currentWeatherSegue {
            if let destinationVC = segue.destination as? CurrentWeatherDetailsViewController {
                destinationVC.location = location
            }
        } else if segue.identifier == SegueIdentifiers.dailyWeatherSegue {
            if let destinationVC = segue.destination as? DailyWeatherDetailsViewController {
                destinationVC.location = location
            }
        } else if segue.identifier == SegueIdentifiers.weeklyWeatherSegue {
            if let destinationVC = segue.destination as? WeeklyWeatherDetailsViewController {
                destinationVC.location = location
            }
        }
        
    }
    

}
