//
//  StorageManager.swift
//  InstaSimulatorByKazbek
//
//  Created by apple on 24.01.2024.
//

import Foundation

final class StorageManager {
    
    static let storageManager = StorageManager()
    
    init(){
        
    }
    
    func urlPuth() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // C - Create
    func saveImage(imageData: Data, imageName: String) {
        var puth = urlPuth()
        
        puth.append(path: imageName + ".jpg")
        do {
            try imageData.write(to: puth)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    //R - Read
    func loadImage(imageName: String)  -> Data {
        var puth = urlPuth()
        puth.append(path: imageName)
        
        guard let imageData = try? Data(contentsOf: puth) else { return Data() }
        
        return imageData
        
    }  
}
