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
    private let displayHelper = WeatherSearchDisplayHepler()
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search City"
        return bar
    }()
    private lazy var tbvResult: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0,
                                                left: 10,
                                                bottom: 0,
                                                right: 0)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .lightGray
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Forecast"
        self.setupSubView()
        self.setupLayout()
    }
    
    private func setupSubView() {
        self.view.addSubview(self.searchBar)
        self.searchBar.delegate = self
        
        self.view.addSubview(self.tbvResult)
        self.tbvResult.register(WeatherResultTableViewCell.self, forCellReuseIdentifier: "WeatherResultTableViewCell")
        self.displayHelper.setupTableView(tbvResult)
    }
    
    private func setupLayout() {
        self.searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        
        self.tbvResult.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
      
        tbvResult.contentInset = UIEdgeInsets(top: 0,
                                              left: 0,
                                              bottom: keyboardSize.height,
                                              right: 0)
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        tbvResult.contentInset = UIEdgeInsets.zero
    }
}

extension WeatherSearchViewController: WeatherSearchViewProtocol {
    func showWeatherData(_ data: [WeatherDisplayModel]) {
        self.displayHelper.setData(data)
    }
    func showError(_ errorMsg: String) {
        let alert = UIAlertController(title: "Error!", message: errorMsg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension WeatherSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let city = searchText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        self.presenter.search(name: city)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
