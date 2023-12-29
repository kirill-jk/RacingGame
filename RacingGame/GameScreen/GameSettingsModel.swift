//
//  GameSettingsModel.swift
//  RacingGame
//
//  Created by Кирилл Курилюк on 26.12.2023.
//

import UIKit

struct GameSettingsModel {
	let userName: String
	let hardness: Double
	let userCar: String
	let backgroundStyle: String
	let backgroundColor: UIColor
	let obstacles: String
	
	init(userName: String, hardness: Int, userCar: Int, backgroundStyle: Int) {
		self.userName = userName
		switch hardness {
		case 0:
			self.hardness = 0.008
		case 1:
			self.hardness = 0.004
		case 2:
			self.hardness = 0.002
		default:
			self.hardness = 0.008

		}
		switch userCar {
		case 0:
			self.userCar = "simpleCar"
		case 1:
			self.userCar = "raceCar"
		case 2:
			self.userCar = "redCube"
		default:
			self.userCar = "simpleCar"

		}
		switch backgroundStyle {
		case 0:
			self.backgroundStyle = "road"
			self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			self.obstacles = "anotherCar"
		case 1:
			self.backgroundStyle = "sand"
			self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
			self.obstacles = "tire"

		case 2:
			self.backgroundStyle = "grayCube"
			self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			self.obstacles = "blue"

		default:
			self.backgroundStyle = "road"
			self.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
			self.obstacles = "anotherCar"
		}
	}
}
