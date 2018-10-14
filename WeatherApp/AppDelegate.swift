//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Adam McGrade on 30/7/18.
//  Copyright © 2018 Adam McGrade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // setup navigation controller and set the initial view controller - select locations
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selectLocationTableVC = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifiers.selectLocationTableView) as! SelectLocationTableViewController
        let navigationController = UINavigationController(rootViewController: selectLocationTableVC)
        
        // test if user has favourite
        // if user has favourite, add the matching view to the navigation controller and set the favourite location
        if let favourite = FavouritesDataController.shared.loadFavouriteFromFile() {            
            let location = favourite.location
            
            switch favourite.forecastType {
            case .current:
                let currentWeatherVC = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifiers.currentWeatherDetailsView) as! CurrentWeatherDetailsViewController
                currentWeatherVC.location = location
                currentWeatherVC.isFavourite = true
                navigationController.pushViewController(currentWeatherVC, animated: false)
            case .daily:
                let dailyWeatherVC = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifiers.dailyWeatherDetailsView) as! DailyWeatherDetailsViewController
                dailyWeatherVC.location = location
                navigationController.pushViewController(dailyWeatherVC, animated: false)
            case .weekly:
                let weeklyWeatherVC = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifiers.weeklyWeatherDetailsView) as! WeeklyWeatherDetailsViewController
                weeklyWeatherVC.location = location
                navigationController.pushViewController(weeklyWeatherVC, animated: false)
            }
        }
        
        // set the root view controller to the navigation controller
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        // setup navigation bar appearance
        let attrs = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 17)!,
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attrs
        UINavigationBar.appearance().tintColor = UIColor.black
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

