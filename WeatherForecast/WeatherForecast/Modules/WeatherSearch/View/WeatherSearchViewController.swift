//
//  WeatherSearchViewController.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import UIKit
import SnapKit

class WeatherSearchViewController: UIViewController {
    var presenter: WeatherSearchPresenterProtocol!
    
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search City"
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Forecast"
        // Do any additional setup after loading the view.
    }
    
    private func setupSubView() {
        self.view.addSubview(self.searchBar)
    }
    
    private func setupLayout() {
        self.searchBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WeatherSearchViewController: WeatherSearchViewProtocol {
    
}
