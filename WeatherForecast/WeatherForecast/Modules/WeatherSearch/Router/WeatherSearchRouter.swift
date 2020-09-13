//
//  WeatherSearchRouter.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import UIKit

class WeatherSearchRouter: WeatherSearchWireframeProtocol {
    
    static func assembleModule(apiService: WeatherSearchAPIServiceProtocol,
                               cacheService: WeatherSearchCacheServiceProtocol) -> UIViewController {
        let view = WeatherSearchViewController()
        let presenter = WeatherSearchPresenter()
        let interactor = WeatherSearchInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.output = presenter
        interactor.apiService = apiService
        interactor.cacheService = cacheService
        
        return view
    }

}
