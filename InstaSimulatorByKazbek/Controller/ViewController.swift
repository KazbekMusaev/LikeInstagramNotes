//
//  ViewController.swift
//  InstaSimulatorByKazbek
//
//  Created by apple on 24.01.2024.
//

import UIKit

final class ViewController: UIViewController {

    
    private lazy var addNewPublicationBtn: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "plus.square.on.square.fill"), for: .normal)
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .white
        return $0
    }(UIButton(primaryAction: actionForAddNewPublication))
    
    private lazy var actionForAddNewPublication = UIAction { [weak self] _ in
            let vc = AddNewPublicationController()
            self?.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Обновили")
        collection.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        settupView()
    }
    
    private func settupView() {
        view.addSubview(collection)
        view.addSubview(addNewPublicationBtn)
        
        NSLayoutConstraint.activate([
            addNewPublicationBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            addNewPublicationBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private lazy var collection: UICollectionView = {
        $0.register(PublicationCell.self, forCellWithReuseIdentifier: PublicationCell.reuseId)
        $0.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseID)
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = UIColor(red: 19/255, green: 20/255, blue: 22/255, alpha: 1)
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: layout))
    
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.itemSize = CGSize(width: (view.frame.size.width - 40), height: (view.frame.size.width - 40))
        $0.headerReferenceSize = CGSize(width: (view.frame.size.width - 40), height: 80)
        $0.minimumLineSpacing = 35
        return $0
    }(UICollectionViewFlowLayout())
    

}

extension ViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let publicationCount = RealmManager.realmManager.publication?.count else { return 0 }
        return publicationCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PublicationCell.reuseId, for: indexPath) as? PublicationCell, let publication = RealmManager.realmManager.publication?[indexPath.item] else { return UICollectionViewCell() }
        cell.configCell(publication: publication)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.reuseID, for: indexPath)
        return header
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
}

