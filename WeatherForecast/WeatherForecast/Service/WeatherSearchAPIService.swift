//
//  WeatherSearchAPIService.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import Foundation
import Alamofire

protocol WeatherSearchAPIServiceProtocol {
    func searchCity(name: String,
                    completion: @escaping  (ForecastWeatherResponseModel?, Error?) -> ())
}

class WeatherSearchAPIService: WeatherSearchAPIServiceProtocol {
    func searchCity(name: String,
                    completion: @escaping  (ForecastWeatherResponseModel?, Error?) -> ()) {
        if let internetError = self.hasErrorInternetConnection() {
            completion(nil, internetError)
            return
        }
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily") else {
            completion(nil, NSError(domain: "", code: 0, userInfo: nil))
            return
        }
        let params = ParamsBuilder()
            .filterByCity(name)
            .addAppId()
            .addNumberOfDaysReturn()
            .addUnits()
            .build()
        
        AF.request(url, parameters:params)
            .responseJSON {[weak self] (response) in
                switch response.result {
                case .success(let responseData):
                    guard let responseJson = responseData as? [String: Any] else {
                        completion(nil, self?.createErrorInternetConnection())
                        return
                    }
                    let forecast = ForecastWeatherResponseModel(JSON: responseJson)
                    completion(forecast, nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    func hasErrorInternetConnection() -> Error? {
        if NetworkReachabilityManager()?.isReachable == false {
            return createErrorInternetConnection()
        }
        return nil
    }
    
    private func createErrorInternetConnection() -> Error {
        return NSError(domain: NSURLErrorDomain,
                       code: NSURLErrorDataNotAllowed,
                       userInfo: [NSLocalizedDescriptionKey : R.networkError])
    }
}

class ParamsBuilder {
    private var params = [String: Any]()
    
    func filterByCity(_ city: String) -> ParamsBuilder {
        params["q"] = city
        return self
    }
    
    func addNumberOfDaysReturn() -> ParamsBuilder {
        params["cnt"] = 7
        return self
    }
    
    func addUnits() -> ParamsBuilder {
        params["units"] = "metric"
        return self
    }
    
    func addAppId() -> ParamsBuilder {
        params["appid"] = "60c6fbeb4b93ac653c492ba806fc346d"
        return self
    }
    
    func build() -> [String: Any] {
        return self.params
    }
}
