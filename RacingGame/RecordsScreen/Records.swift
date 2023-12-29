//
//  Records.swift
//  RacingGame
//
//  Created by Кирилл Курилюк on 28.12.2023.
//

import Foundation


class Records: Codable {
	var records: [Record] = []
	
	func addRecord(_ record: Record) {
		records.append(record)
	}
}

struct Record: Codable {
	let name: String
	let record: Int
}


