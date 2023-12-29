//
//  RecordsViewController.swift
//  RacingGame
//
//  Created by Кирилл Курилюк on 25.12.2023.
//

import UIKit

class RecordsViewController: UIViewController {
	
	let recordsData = UserDefaults.standard.value(Records.self, forKey: "RecordsKey")
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(RecordsTableViewCell.self, forCellReuseIdentifier: RecordsTableViewCell.identifier)
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = .leastNonzeroMagnitude
		return tableView
	}()
	private var namesArray: [String]? = []
	private var recordsArray: [String]? = []

	override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.isNavigationBarHidden = false
		configureUI()
    }
	private func configureUI() {
		title = "Records"
		if let arr = recordsData?.records {
			let sortedArray = arr.sorted(by: { $0.record > $1.record })
			namesArray = sortedArray.map({$0.name})
			recordsArray = sortedArray.map({"\($0.record)"})
		}
		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}


extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		(namesArray?.count ?? 11) - 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordsTableViewCell.identifier, for: indexPath) as? RecordsTableViewCell else {
			return UITableViewCell()
		}
		cell.configure(with: RecordCellModel(name: namesArray?[indexPath.row] ?? "..." ,record: recordsArray?[indexPath.row] ?? "..." )) { text in
			print("Button pressed: \(text!)")
		}
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
