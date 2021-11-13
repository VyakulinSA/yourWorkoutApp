//
//  ImagesStorageManager.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 13.11.2021.
//

import Foundation
import UIKit

protocol ImagesStorageManagerProtocol {
    func save(image: UIImage?, with imageName: String) -> String?
    func load(imageName: String) -> UIImage?
}

class ImagesStorageManager: ImagesStorageManagerProtocol {
    func save(image: UIImage?, with imageName: String) -> String? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("remove old image")
            } catch let removeError {
                print(removeError.localizedDescription)
            }
        }
        
        guard let imageData = image?.jpegData(compressionQuality: 1.0) ?? image?.pngData() else {return nil}
        
        do {
            try imageData.write(to: fileURL)
        } catch let saveError {
            print(saveError.localizedDescription)
        }
        return fileName
    }
    
    func load(imageName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMack = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMack, true)
        
        if let dirPath = path.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(imageName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
}
