//
//  WeatherSearchProtocol.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import UIKit

protocol WeatherSearchWireframeProtocol: class {
    static func assembleModule() -> UIViewController
}

protocol WeatherSearchViewProtocol: class {
    var presenter: WeatherSearchPresenterProtocol! { get set }
}

protocol WeatherSearchPresenterProtocol: class {
    var view: WeatherSearchViewProtocol? { get set }
    var interactor: WeatherSearchInteractorProtocol! { get set }
}

protocol WeatherSearchInteractorProtocol: class {
    var output: WeatherSearchInteractorOutputProtocol? { get set }
}

protocol WeatherSearchInteractorOutputProtocol: class {
}
