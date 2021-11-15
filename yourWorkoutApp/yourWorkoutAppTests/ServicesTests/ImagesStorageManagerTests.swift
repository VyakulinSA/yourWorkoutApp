//
//  ImagesStorageManagerTests.swift
//  yourWorkoutAppTests
//
//  Created by Вякулин Сергей on 14.11.2021.
//

import XCTest
@testable import yourWorkoutApp

class ImagesStorageManagerTests: XCTestCase {
    var imagesStorageManager: ImagesStorageManager!

    override func setUpWithError() throws {
        imagesStorageManager = ImagesStorageManager()
    }

    override func tearDownWithError() throws {
        imagesStorageManager = nil
    }
    
    func testSaveAndLoad() {
        let image = UIImage(systemName: "pencil")
        let imageName = "testImage_112233"
        
        let name = imagesStorageManager.save(image: image, withName: imageName)
        
        XCTAssertNotNil(name)
        XCTAssertTrue(name == imageName)
        
        let savedImage = imagesStorageManager.load(imageName: name ?? "")

        XCTAssertNotNil(savedImage)
        
        let deleteImage = imagesStorageManager.save(image: nil, withName: imageName)
        
        XCTAssertNil(deleteImage)
        
        let savedImageAfterDelete = imagesStorageManager.load(imageName: imageName)
        
        XCTAssertNil(savedImageAfterDelete)
        
    }
    
    

}
