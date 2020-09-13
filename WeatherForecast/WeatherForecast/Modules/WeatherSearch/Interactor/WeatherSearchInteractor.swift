//
//  WeatherSearchInteractor.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import Foundation

class WeatherSearchInteractor: WeatherSearchInteractorProtocol {
    weak var output: WeatherSearchInteractorOutputProtocol?
    var apiService: WeatherSearchAPIServiceProtocol!
    var cacheService: WeatherSearchCacheServiceProtocol!
    private let timeToLive: TimeInterval = 3600
    
    func searchWeatherOfCity(name: String) {
        self.searchFromCache(name) {[weak self] (cacheData) in
            guard let weakSelf = self else { return }
            if let data = cacheData {
                DispatchQueue.main.async {
                    weakSelf.output?.weatherSearchResult(data)
                }
                return
            }
            weakSelf.searchFromAPI(name)
        }
    }
    
    private func cacheData(name: String, data: ForecastWeatherResponseModel) {
        var dataForCache = data
        dataForCache.exprieTime = Date().timeIntervalSince1970 + self.timeToLive
        self.cacheService.saveCity(name: name, data: dataForCache)
    }
    
    private func searchFromCache(_ name: String, completion: @escaping  (ForecastWeatherResponseModel?) -> ()) {
        self.cacheService.searchCity(name: name) { (result) in
            guard let result = result,
                let exprieTime = result.exprieTime,
                exprieTime > Date().timeIntervalSince1970 else {
                completion(nil)
                return
            }
            completion(result)
        }
    }
    
    private func searchFromAPI(_ name: String) {
        self.apiService.searchCity(name: name) {[weak self] (result, error) in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    weakSelf.output?.weatherSearchError(error.localizedDescription)
                    return
                }
                
                guard let result = result else {
                    weakSelf.output?.weatherSearchError(R.unknownError)
                    return
                }
                
                weakSelf.cacheData(name: name, data: result)
                weakSelf.output?.weatherSearchResult(result)
            }
        }
    }
}
