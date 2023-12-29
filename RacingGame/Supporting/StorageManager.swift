//
//  StorageManager.swift
//  RacingGame
//
//  Created by Кирилл Курилюк on 25.12.2023.
//

import UIKit

final class StorageManager {
	
	func saveImage(_ image: UIImage) throws -> String? {
		guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		let name = UUID().uuidString
		let fileURL = directory.appendingPathComponent(name)
		
		guard let data = image.jpegData(compressionQuality: 1.0) else { return nil }
		try data.write(to: fileURL)
		
		return name
	}
	
	func loadImage(withName name: String) -> UIImage? {
		guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		let fileURL = directory.appendingPathComponent(name)
		
		guard let imageData = try? Data(contentsOf: fileURL) else { return nil }
		let image = UIImage(data: imageData)
		
		return image
	}
	
}


