//
//  HeaderCell.swift
//  InstaSimulatorByKazbek
//
//  Created by apple on 25.01.2024.
//

import UIKit

class HeaderCell: UICollectionReusableView {
        static let reuseID = "HeaderCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainLabel)
        
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Главная"
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 24)
        return $0
    }(UILabel())
    
}
