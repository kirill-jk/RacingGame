//
//  User.swift
//  RacingGame
//
//  Created by Кирилл Курилюк on 25.12.2023.
//

import Foundation

final class User: Codable {
	
	let picture: String
	let userName: String
	let	car: Int
	let background: Int
	let difficulty: Int
	
	init(picture: String, userName: String, car: Int, background: Int, difficulty: Int) {
		self.picture = picture
		self.userName = userName
		self.car = car
		self.background = background
		self.difficulty = difficulty
	}
}
