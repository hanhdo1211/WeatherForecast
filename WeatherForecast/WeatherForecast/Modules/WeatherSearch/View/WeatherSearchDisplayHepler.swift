//
//  WeatherSearchDisplayHepler.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import UIKit

class WeatherSearchDisplayHepler: NSObject {
    var tbvResult: UITableView!
    var weatherData: [WeatherDisplayModel] = []
    func setupTableView(_ tableView: UITableView) {
        self.tbvResult = tableView
        self.tbvResult.dataSource = self
    }
    func setData(_ data: [WeatherDisplayModel]) {
        self.weatherData = data
        tbvResult.reloadData()
    }
}

extension WeatherSearchDisplayHepler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherResultTableViewCell") as? WeatherResultTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(data: self.weatherData[indexPath.row])
        return cell
    }
}

