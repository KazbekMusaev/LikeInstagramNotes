//
//  SettupPublication.swift
//  InstaSimulatorByKazbek
//
//  Created by apple on 25.01.2024.
//

import UIKit

class SettupPublication: UIViewController {
    
    var delegate: AddNewPublicationProtocol?
    
    func configView(image: UIImage) {
        self.image.image = image
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 19/255, green: 20/255, blue: 22/255, alpha: 1)
        settupView()
    }

    private func settupView() {
        view.addSubview(backBtn)
        view.addSubview(image)
        view.addSubview(namePublicationTextField)
        view.addSubview(textPublication)
        view.addSubview(saveBtn)
        
        NSLayoutConstraint.activate([
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            
            image.topAnchor.constraint(equalTo: backBtn.bottomAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            namePublicationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            namePublicationTextField.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 45),
            namePublicationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            textPublication.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textPublication.topAnchor.constraint(equalTo: namePublicationTextField.bottomAnchor, constant: 20),
            textPublication.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            saveBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saveBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
    
    }
    
    private lazy var backBtn: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "arrow.backward.square"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.tintColor = .white
        return $0
    }(UIButton(primaryAction: actionBackBtn))
    
    private lazy var actionBackBtn = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.navigationController?.popViewController(animated: true)
    }
    
    private lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.heightAnchor.constraint(equalToConstant: 370).isActive = true
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var namePublicationTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Название заголовка"
        $0.delegate = self
        $0.tag = 1
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.backgroundColor = UIColor(red: 14/255, green: 15/255, blue: 17/255, alpha: 1)
        $0.layer.cornerRadius = 30
        return $0
    }(UITextField())
    
    private lazy var textPublication: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(red: 14/255, green: 15/255, blue: 17/255, alpha: 1)
        $0.heightAnchor.constraint(equalToConstant: 115).isActive = true
        $0.delegate = self
        $0.tag = 2
        $0.placeholder = "Описание"
        $0.layer.cornerRadius = 30
        return $0
    }(UITextField())
    
    private lazy var saveBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(red: 14/255, green: 15/255, blue: 17/255, alpha: 1)
        $0.setTitle("Сохранить", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.heightAnchor.constraint(equalToConstant: 55).isActive = true
        $0.layer.cornerRadius = 30
        return $0
    }(UIButton(primaryAction: actionSaveBtn))
    
    private lazy var actionSaveBtn = UIAction { [weak self] _ in
        guard let self = self else { return }
        
        let publication = Publication()
        
        if let textPublication = self.textPublication.text {
            publication.text = textPublication
        }
        if let namePublication = self.namePublicationTextField.text {
            publication.publicationName = namePublication
        }
        let imageName = UUID().uuidString
        publication.imageName = imageName
        
        if let image = self.image.image {
            if let imageData = image.jpegData(compressionQuality: 0.5) {
                StorageManager.storageManager.saveImage(imageData: imageData, imageName: imageName )
            }
        }
        RealmManager.realmManager.createPublication(publication: publication)
        self.delegate?.popController()
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SettupPublication: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}


