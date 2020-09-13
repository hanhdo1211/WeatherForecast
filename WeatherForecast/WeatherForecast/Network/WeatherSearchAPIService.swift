//
//  WeatherSearchAPIService.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

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
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily?cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric") else {
            completion(nil, NSError(domain: "", code: 0, userInfo: nil))
            return
        }
        let params = ["q": name]
        print("city: name")
        AF.request(url,
                   parameters:params)
            .responseJSON { (response) in
            switch response.result {
            case .success(let responseData):
                guard let responseJson = responseData as? [String: Any] else {
                    let error = NSError(domain: NSURLErrorDomain,
                                        code: NSURLErrorDataNotAllowed,
                                        userInfo: [NSLocalizedDescriptionKey : "Vui lòng kiểm tra lại kết nối mạng"])
                    completion(nil, error)
                    return
                }
                let forecast = ForecastWeatherResponseModel(JSON: responseJson)
                print("forecast \(forecast)")
                completion(forecast, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func hasErrorInternetConnection() -> Error? {
        if NetworkReachabilityManager()?.isReachable == false {
            return NSError(domain: NSURLErrorDomain,
                           code: NSURLErrorDataNotAllowed,
                           userInfo: [NSLocalizedDescriptionKey : "Vui lòng kiểm tra lại kết nối mạng"])
        }
        return nil
    }
}
