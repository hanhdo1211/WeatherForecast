//
//  WeatherForecastInteractorTests.swift
//  WeatherForecastTests
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import XCTest

class WeatherSearchAPIServiceMock: WeatherSearchAPIServiceProtocol {
    var mockOutput: (ForecastWeatherResponseModel?, Error?)!
    func searchCity(name: String, completion: @escaping (ForecastWeatherResponseModel?, Error?) -> ()) {
        completion(mockOutput.0, mockOutput.1)
    }
}

class WeatherSearchCacheServiceMock: WeatherSearchCacheServiceProtocol {
    var callSaveCity = 0
    var mockOutput: ForecastWeatherResponseModel?
    func saveCity(name: String, data: ForecastWeatherResponseModel) {
        callSaveCity += 1
    }
    
    func searchCity(name: String, completion: @escaping (ForecastWeatherResponseModel?) -> ()) {
        completion(mockOutput)
    }
}

class WeatherSearchPresenterMock: WeatherSearchInteractorOutputProtocol {
    var searchResultHandler:(() -> Void)!
    var searchResultError:(() -> Void)!
    var result: ForecastWeatherResponseModel!
    var errorMess: String!
    func weatherSearchResult(_ result: ForecastWeatherResponseModel) {
        self.result = result
        searchResultHandler()
    }
    
    func weatherSearchError(_ errorMess: String) {
        self.errorMess = errorMess
        searchResultError()
    }
}

class WeatherForecastInteractorTests: XCTestCase {
    var cacheService: WeatherSearchCacheServiceMock!
    var apiService: WeatherSearchAPIServiceMock!
    var output: WeatherSearchPresenterMock!
    var interactor: WeatherSearchInteractorProtocol!
    
    override func setUpWithError() throws {
//        weatherSearchInteractor =
        output = WeatherSearchPresenterMock()
        apiService = WeatherSearchAPIServiceMock()
        cacheService = WeatherSearchCacheServiceMock()
        
        interactor = WeatherSearchInteractor()
        interactor.output = output
        interactor.apiService = apiService
        interactor.cacheService = cacheService
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchHaveResultFromAPI() {
        let exp = expectation(description: "Search weather")
        let mockCacheJsonString = "{\"cod\":\"200\",\"list\":[{\"humidity\":64,\"weather\":[{\"description\":\"heavy intensity rain\",\"main\":\"Rain\"}],\"dt\":1599969600,\"pressure\":1010,\"temp\":{\"min\":25,\"max\":32.75}},{\"temp\":{\"max\":31.41,\"min\":25.489999999999998},\"humidity\":64,\"dt\":1600056000,\"pressure\":1010,\"weather\":[{\"main\":\"Rain\",\"description\":\"moderate rain\"}]},{\"humidity\":67,\"temp\":{\"max\":31.399999999999999,\"min\":24.649999999999999},\"dt\":1600142400,\"pressure\":1010,\"weather\":[{\"description\":\"moderate rain\",\"main\":\"Rain\"}]},{\"dt\":1600228800,\"temp\":{\"max\":30.760000000000002,\"min\":24.809999999999999},\"weather\":[{\"description\":\"moderate rain\",\"main\":\"Rain\"}],\"pressure\":1010,\"humidity\":66},{\"pressure\":1008,\"dt\":1600315200,\"weather\":[{\"main\":\"Rain\",\"description\":\"moderate rain\"}],\"humidity\":70,\"temp\":{\"min\":25.530000000000001,\"max\":31.780000000000001}},{\"weather\":[{\"main\":\"Rain\",\"description\":\"moderate rain\"}],\"temp\":{\"min\":25.260000000000002,\"max\":28.57},\"dt\":1600401600,\"pressure\":1006,\"humidity\":74},{\"dt\":1600488000,\"humidity\":82,\"weather\":[{\"description\":\"heavy intensity rain\",\"main\":\"Rain\"}],\"temp\":{\"max\":30.120000000000001,\"min\":25.050000000000001},\"pressure\":1007}],\"exprieTime\":1600015160.6909208}"
        let mockData = ForecastWeatherResponseModel(JSONString: mockCacheJsonString)
        
        apiService.mockOutput = (mockData, nil)
        cacheService.mockOutput = nil
        output.searchResultHandler = {
            exp.fulfill()
        }
        
        interactor.searchWeatherOfCity(name:"dummy")
        waitForExpectations(timeout: 3, handler: nil)
        self.validateSearchHaveResultFromAPI()
    }
    
    func testSearchHaveNoResultFromAPI() {
        let exp = expectation(description: "Search weather")
        let mockCacheJsonString = "{\"cod\":\"404\",\"message\":\"city not found\"}"
        let mockData = ForecastWeatherResponseModel(JSONString: mockCacheJsonString)
        
        apiService.mockOutput = (mockData, nil)
        cacheService.mockOutput = nil
        output.searchResultHandler = {
            exp.fulfill()
        }
        
        interactor.searchWeatherOfCity(name:"dummy")
        waitForExpectations(timeout: 3, handler: nil)
        self.validateSearchHaveNoResultFromAPI()
    }
    
    func testSearchErrorNetWork() {
        let exp = expectation(description: "Search weather")
        let error = NSError(domain: NSURLErrorDomain,
                            code: NSURLErrorDataNotAllowed,
                            userInfo: [NSLocalizedDescriptionKey : R.networkError])
        apiService.mockOutput = (nil, error)
        cacheService.mockOutput = nil
        output.searchResultError = {
            exp.fulfill()
        }
        
        interactor.searchWeatherOfCity(name:"dummy")
        waitForExpectations(timeout: 3, handler: nil)
        self.validateSearchError()
    }
    
    func validateSearchHaveResultFromAPI() {
        XCTAssertTrue(cacheService.callSaveCity == 1, "Cache not called")
        XCTAssertTrue(output.result.returnCode == "200", "Wrong return code")
        XCTAssertTrue(output.result.listDay!.count == 7, "Wrong num of days")
    }

    func validateSearchHaveNoResultFromAPI() {
        XCTAssertTrue(output.result.returnCode == "404", "Wrong return code")
        XCTAssertTrue(output.result.returnMessage == "city not found", "Wrong error message")
    }

    func validateSearchError() {
        XCTAssertTrue(output.errorMess == R.networkError, "Wrong error message")
    }
}
