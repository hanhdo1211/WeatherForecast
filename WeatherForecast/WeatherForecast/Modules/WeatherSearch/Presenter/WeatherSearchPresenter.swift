//
//  WeatherSearchPresenter.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import Foundation

class WeatherSearchPresenter: WeatherSearchPresenterProtocol {
    weak var view: WeatherSearchViewProtocol?
    var interactor: WeatherSearchInteractorProtocol!
    
}

extension WeatherSearchPresenter: WeatherSearchInteractorOutputProtocol {
}
