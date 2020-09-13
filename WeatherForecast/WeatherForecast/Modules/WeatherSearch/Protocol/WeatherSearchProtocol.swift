//
//  WeatherSearchProtocol.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import UIKit

protocol WeatherSearchWireframeProtocol: class {
    static func assembleModule(apiService: WeatherSearchAPIServiceProtocol,
                               cacheService: WeatherSearchCacheServiceProtocol) -> UIViewController
}

protocol WeatherSearchViewProtocol: class {
    var presenter: WeatherSearchPresenterProtocol! { get set }
    
    func showWeatherData(_ data: [WeatherDisplayModel])
    func showError(_ errorMsg: String)
}

protocol WeatherSearchPresenterProtocol: class {
    var view: WeatherSearchViewProtocol? { get set }
    var interactor: WeatherSearchInteractorProtocol! { get set }
    
    func search(name: String)
}

protocol WeatherSearchInteractorProtocol: class {
    var output: WeatherSearchInteractorOutputProtocol? { get set }
    var apiService: WeatherSearchAPIServiceProtocol! {get set}
    var cacheService: WeatherSearchCacheServiceProtocol! {get set}
    
    func searchWeatherOfCity(name: String)
}

protocol WeatherSearchInteractorOutputProtocol: class {
    func weatherSearchResult(_ result: ForecastWeatherResponseModel)
    func weatherSearchError(_ errorMess: String)
}
