//
//  Publication.swift
//  InstaSimulatorByKazbek
//
//  Created by apple on 24.01.2024.
//

import Foundation
import RealmSwift

final class Publication: Object {
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var publicationName: String
    @Persisted var imageName: String
    @Persisted var text: String
    @Persisted var date = Date()
}
