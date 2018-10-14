//
//  SelectLocationTableViewController.swift
//  WeatherApp
//
//  Created by Adam McGrade on 30/7/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import UIKit

class SelectLocationTableViewController: UITableViewController {

    let locations = Location.all()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SelectLocationTableViewCell", bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.locationCell)
    }

    // MARK: - TableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.locationCell, for: indexPath) as! SelectLocationTableViewCell
        let location = locations[indexPath.row]
        cell.configure(with: location)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifiers.locationToForecastSegue, sender: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.locationToForecastSegue {
            if let destinationVC = segue.destination as? SelectForceastTableViewController,
            let index = tableView.indexPathForSelectedRow {
                destinationVC.location = locations[index.row]
            }
        }
        
    }

}
