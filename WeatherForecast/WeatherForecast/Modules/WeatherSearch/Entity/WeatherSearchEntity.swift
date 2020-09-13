//
//  WeatherSearchEntity.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import Foundation
import ObjectMapper

struct ForecastWeatherResponseModel: Mappable {
    var listDay: [DayResponseModel]?
    var returnCode: String?
    var returnMessage: String?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        listDay         <- map["list"]
        returnCode      <- map["cod"]
        returnMessage   <- map["message"]
    }
}

struct CityResponseModel: Mappable {
    var name: String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        name     <- map["name"]
    }
}

struct DayResponseModel: Mappable {
    var timeInterval: TimeInterval?
    var pressure, humidity: Int?
    var listWeather:[WeatherResponseModel]?
    var temp:TempResponseModel?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        timeInterval       <- map["dt"]
        pressure        <- map["pressure"]
        humidity        <- map["humidity"]
        listWeather     <- map["weather"]
        temp        <- map["temp"]
    }
}

struct TempResponseModel: Mappable {
    var min, max: Double?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        min     <- map["min"]
        max     <- map["max"]
    }
}

struct WeatherResponseModel: Mappable {
    var main: String?
    var desc: String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        main     <- map["main"]
        desc     <- map["description"]
    }
}

struct WeatherDisplayModel {
    let date: String
    let avgTemp: String
    let pressure: String
    let humidity: String
    let desc: String
}
