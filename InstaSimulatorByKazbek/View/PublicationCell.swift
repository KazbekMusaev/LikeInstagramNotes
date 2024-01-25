//
//  PublicationCell.swift
//  InstaSimulatorByKazbek
//
//  Created by apple on 24.01.2024.
//

import UIKit

class PublicationCell: UICollectionViewCell {
    
    static let reuseId = "PublicationCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settupCell()
    }
    
    func configCell(publication: Publication) {
        self.image.image = UIImage(data: StorageManager.storageManager.loadImage(imageName: publication.imageName + ".jpg"))
        self.nameOfPost.text = publication.publicationName
        self.publicationText.text = publication.text
    }
    
    private func settupCell() {
        layer.cornerRadius = 30
        clipsToBounds = true
        
        addSubview(image)
        image.addSubview(nameOfPost)
        image.addSubview(publicationText)
        
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameOfPost.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 20),
            nameOfPost.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -20),
            nameOfPost.topAnchor.constraint(equalTo: image.topAnchor, constant: 250),
            
            publicationText.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 20),
            publicationText.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -20),
            publicationText.topAnchor.constraint(equalTo: nameOfPost.bottomAnchor, constant: 10),
            publicationText.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -30),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    private lazy var nameOfPost: UILabel = {
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var publicationText: UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14)
        return $0
    }(UILabel())
    
}
