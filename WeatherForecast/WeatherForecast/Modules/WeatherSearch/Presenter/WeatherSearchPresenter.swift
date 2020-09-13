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
    
    private var timer: Timer?
    private var searchCity = ""
    private let returnCodeSuccess = "200"
    
    func search(name: String) {
        timer?.invalidate()
        self.searchCity = name
        guard name.count >= 3 else { return }
        timer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(self.performSearch),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc private func performSearch() {
        self.interactor.searchWeatherOfCity(name: self.searchCity)
    }
}

extension WeatherSearchPresenter: WeatherSearchInteractorOutputProtocol {
    func weatherSearchResult(_ result: ForecastWeatherResponseModel) {
        guard let returnCode = result.returnCode,
            returnCode == self.returnCodeSuccess,
            let listDay = result.listDay else {
                self.weatherSearchError(result.returnMessage ?? R.unknownError)
            return
        }
        
        let displayModel = self.parseToDisplayModel(listDay)
        if displayModel.isEmpty {
            self.weatherSearchError(R.dataEmptyError)
            return
        }
        
        self.view?.showWeatherData(displayModel)
    }
    
    func weatherSearchError(_ errorMess: String) {
        self.view?.showError(errorMess)
    }
    
    private func parseToDisplayModel(_ listDay: [DayResponseModel]) -> [WeatherDisplayModel] {
        var result = [WeatherDisplayModel]()
        if listDay.isEmpty {
            return result
        }
        for weatherByDayModel in listDay {
            guard let timeInterval = weatherByDayModel.timeInterval,
                let temp = weatherByDayModel.temp,
                let pressureValue = weatherByDayModel.pressure,
                let humidityValue = weatherByDayModel.humidity,
                let weatherList = weatherByDayModel.listWeather else {
                    continue
            }
            
            let dateString = String(format: R.formatDateLbl,
                                    self.parseToDateString(timeInterval))
            let avgTemp = String(format: R.formatAvgTempLbl,
                                 self.parseToAverageTemp(temp))  
            let pressure = String(format: R.formatPressureLbl,
                                  pressureValue)
            let humidity = String(format: R.formatHumidityLbl,
                                  humidityValue)
            let desc = String(format: R.formatDescriptionLbl,
                              self.parseToDesc(weatherList))
            
            let displayModel = WeatherDisplayModel(date: dateString,
                                                   avgTemp: avgTemp,
                                                   pressure: pressure,
                                                   humidity: humidity,
                                                   desc: desc)
            result.append(displayModel)
        }
        
        return result
    }
    
    private func parseToDateString(_ timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let formater = DateFormatter()
        formater.dateFormat = "EEE, dd MMM yyyy"
        return formater.string(from: date)
    }
    
    private func parseToAverageTemp(_ temp: TempResponseModel) -> Int {
        guard let max = temp.max,
            let min = temp.min else {
                return 0
        }
        return Int(((max + min) / 2.0).rounded(.toNearestOrEven))
    }
    
    private func parseToDesc(_ weather: [WeatherResponseModel]) -> String {
        return weather.compactMap({ $0.desc }).joined(separator: ", ")
    }
}
