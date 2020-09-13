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
    
    func searchWeatherOfCity(name: String) {
        apiService.searchCity(name: name) {[weak self] (result, error) in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    weakSelf.output?.weatherSearchError(error.localizedDescription)
                    return
                }
                
                guard let result = result else {
                    weakSelf.output?.weatherSearchError("Co loi xay ra")
                    return
                }
                weakSelf.output?.weatherSearchResult(result)
            }
        }
    }
}
