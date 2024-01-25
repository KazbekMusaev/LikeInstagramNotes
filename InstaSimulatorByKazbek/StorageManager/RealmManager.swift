//
//  RealmManager.swift
//  InstaSimulatorByKazbek
//
//  Created by apple on 24.01.2024.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    static let realmManager = RealmManager()
    
    let realm = try! Realm()
    
    var publication: [Publication]?
    
    init() {
        readPublication()
    }
    
    // CRUD
    
    // C - Create
    func createPublication(publication: Publication){
        do {
            try realm.write {
                realm.add(publication)
            }
        } catch {
            print(error.localizedDescription)
        }
        readPublication()
    }
    // R - Read
    func readPublication() {
        let publications = realm.objects(Publication.self)
        self.publication = Array(publications)
    }
    // U - Update
    func updatePublication(id: String, newImageName: String?, newNamePublication: String?, newText: String?) {
        guard let publication = realm.object(ofType: Publication.self, forPrimaryKey: id) else { print("Нет элемента по данному ID"); return }
        do {
            try realm.write {
                publication.date = Date()
                if let newImageName = newImageName {
                    publication.imageName = newImageName
                }
                if let newNamePublication = newNamePublication {
                    publication.publicationName = newNamePublication
                }
                if let newText = newText {
                    publication.text = newText
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        readPublication()
    }
    
    // D - Delete
    func deletePublication(id: String) {
        guard let publication = realm.object(ofType: Publication.self, forPrimaryKey: id) else { print("Нет публикации по данному ID"); return}
        do {
            try realm.write {
                realm.delete(publication)
            }
        } catch {
            
        }
        readPublication()
    }
    
    
}
