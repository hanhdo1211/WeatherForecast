//
//  RootRouter.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import UIKit
protocol RootWireframe: class {
    func showWeatherSearchScreen(in window: UIWindow)
}

class RootRouter: RootWireframe {
    
    func showWeatherSearchScreen(in window: UIWindow) {
        let weatherSearchViewController = WeatherSearchRouter.assembleModule(apiService: WeatherSearchAPIService(),
                                                                             cacheService: WeatherSearchCacheService())
        let navigationController = UINavigationController(rootViewController: weatherSearchViewController)
        
        window.rootViewController = navigationController;

        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
    }
}
