//
//  WeatherResultTableViewCell.swift
//  WeatherForecast
//
//  Created by HanhDV on 9/13/20.
//  Copyright © 2020 LAP12005. All rights reserved.
//

import UIKit

class WeatherResultTableViewCell: UITableViewCell {
    let holderView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 4
        view.backgroundColor = .clear
        return view
    }()
    lazy var lblDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    lazy var lblAvgTemp: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    lazy var lblPressure: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    lazy var lblHumidity: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    lazy var lblDesc: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubView()
        self.setupConstraints()
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubView() {
        self.contentView.addSubview(self.holderView)
        self.holderView.addArrangedSubview(self.lblDate)
        self.holderView.addArrangedSubview(self.lblAvgTemp)
        self.holderView.addArrangedSubview(self.lblPressure)
        self.holderView.addArrangedSubview(self.lblHumidity)
        self.holderView.addArrangedSubview(self.lblDesc)
    }
    
    private func setupConstraints() {
        holderView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
    }

    func setData(data: WeatherDisplayModel) {
        self.lblDate.text = data.date
        self.lblAvgTemp.text = data.avgTemp
        self.lblPressure.text = data.pressure
        self.lblHumidity.text = data.humidity
        self.lblDesc.text = data.desc
    }
}
