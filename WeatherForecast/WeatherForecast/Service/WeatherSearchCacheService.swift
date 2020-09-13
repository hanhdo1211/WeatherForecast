//
//  WeatherSearchCacheService.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import Foundation
import PINCache

protocol WeatherSearchCacheServiceProtocol {
    func searchCity(name: String,
                    completion: @escaping  (ForecastWeatherResponseModel?) -> ())
    func saveCity(name: String, data: ForecastWeatherResponseModel)
}

class WeatherSearchCacheService: WeatherSearchCacheServiceProtocol {
    func searchCity(name: String, completion: @escaping (ForecastWeatherResponseModel?) -> ()) {
        PINCache.shared.object(forKeyAsync: name) { (cache, key, data) in
            guard let json = data as? [String: Any] else {
                completion(nil)
                return
            }
            let cacheData = ForecastWeatherResponseModel(JSON: json)
            completion(cacheData)
        }
    }
    
    func saveCity(name: String, data: ForecastWeatherResponseModel) {
        PINCache.shared.setObject(data.toJSON(), forKey: name)
    }
}
