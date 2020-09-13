//
//  WeatherForecastPresenterTests.swift
//  WeatherForecastTests
//
//  Created by HanhDV on 9/14/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import XCTest
class WeatherSearchViewMock: WeatherSearchViewProtocol {
    var presenter: WeatherSearchPresenterProtocol!
    var showWeatherHandler:(() -> Void)!
    var result: [WeatherDisplayModel]!
    
    func showWeatherData(_ data: [WeatherDisplayModel]) {
        self.result = data
        showWeatherHandler()
    }
    func showError(_ errorMsg: String) {
    }
}
class WeatherForecastPresenterTests: XCTestCase {
    var presenter: WeatherSearchPresenter!
    var view: WeatherSearchViewMock!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = WeatherSearchViewMock()
        presenter = WeatherSearchPresenter()
        presenter.view = view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testParseData() {
        let exp = expectation(description: "Parse data")
        let mockCacheJsonString = "{\"cod\":\"200\",\"list\":[{\"humidity\":64,\"weather\":[{\"description\":\"heavy intensity rain\",\"main\":\"Rain\"}],\"dt\":1599969600,\"pressure\":1010,\"temp\":{\"min\":25,\"max\":32.75}},{\"temp\":{\"max\":31.41,\"min\":25.489999999999998},\"humidity\":64,\"dt\":1600056000,\"pressure\":1010,\"weather\":[{\"main\":\"Rain\",\"description\":\"moderate rain\"}]},{\"humidity\":67,\"temp\":{\"max\":31.399999999999999,\"min\":24.649999999999999},\"dt\":1600142400,\"pressure\":1010,\"weather\":[{\"description\":\"moderate rain\",\"main\":\"Rain\"}]},{\"dt\":1600228800,\"temp\":{\"max\":30.760000000000002,\"min\":24.809999999999999},\"weather\":[{\"description\":\"moderate rain\",\"main\":\"Rain\"}],\"pressure\":1010,\"humidity\":66},{\"pressure\":1008,\"dt\":1600315200,\"weather\":[{\"main\":\"Rain\",\"description\":\"moderate rain\"}],\"humidity\":70,\"temp\":{\"min\":25.530000000000001,\"max\":31.780000000000001}},{\"weather\":[{\"main\":\"Rain\",\"description\":\"moderate rain\"}],\"temp\":{\"min\":25.260000000000002,\"max\":28.57},\"dt\":1600401600,\"pressure\":1006,\"humidity\":74},{\"dt\":1600488000,\"humidity\":82,\"weather\":[{\"description\":\"heavy intensity rain\",\"main\":\"Rain\"}],\"temp\":{\"max\":30.120000000000001,\"min\":25.050000000000001},\"pressure\":1007}],\"exprieTime\":1600015160.6909208}"
        let mockData = ForecastWeatherResponseModel(JSONString: mockCacheJsonString)
        view.showWeatherHandler = {
            exp.fulfill()
        }
        self.presenter.weatherSearchResult(mockData!)
        waitForExpectations(timeout: 1, handler: nil)
        self.validateParseData()
    }
    
    func validateParseData() {
        let count = self.view.result.count
        XCTAssertTrue(count > 0, "Wrong num of item")
        XCTAssertTrue(count == 7, "Wrong num of item")
        let data = self.view.result[0]
        XCTAssertTrue(data.date == "Date: Sun, 13 Sep 2020", "Wrong Date ~ \(data.date)")
        XCTAssertTrue(data.avgTemp == "Average Temperature: 29ºC", "Wrong Avg temp ~ [\(data.avgTemp)]")
        XCTAssertTrue(data.humidity == "Humidity: 64%", "Wrong Humidity ~ \(data.humidity)")
        XCTAssertTrue(data.pressure == "Pressure: 1010", "Wrong Pressure ~ \(data.pressure)")
        XCTAssertTrue(data.desc == "Description: heavy intensity rain", "Wrong descriptionString ~ \(data.desc)")
    }
}
