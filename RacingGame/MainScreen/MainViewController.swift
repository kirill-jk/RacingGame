//
//  ViewController.swift
//  RacingGame
//
//  Created by Кирилл Курилюк on 25.12.2023.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
	
	private let gameButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Play", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
		button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
		button.layer.cornerRadius = 10
		button.titleLabel?.numberOfLines = 0
		
		return button
	}()
	
	private let recordButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Records", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
		button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
		button.layer.cornerRadius = 10
		button.titleLabel?.numberOfLines = 0
		
		return button
	}()
	
	private let settinngsButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Settings", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
		button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
		button.layer.cornerRadius = 10
		button.titleLabel?.numberOfLines = 0
		
		return button
	}()

	
	//MARK: - lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
	}
	
	private func setupUI() {
		view.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
		view.addSubview(gameButton)
		view.addSubview(recordButton)
		view.addSubview(settinngsButton)
		
		gameButton.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalToSuperview().offset(250)
			make.height.equalTo(60)
			make.width.equalTo(250)
		}
		
		recordButton.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(gameButton).offset(150)
			make.height.equalTo(60)
			make.width.equalTo(250)
		}
		
		settinngsButton.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(recordButton).offset(150)
			make.height.equalTo(60)
			make.width.equalTo(250)
		}
		
		gameButton.addTarget(self, action: #selector(gameButtonPressed), for: .touchUpInside)
		recordButton.addTarget(self, action: #selector(recordButtonPressed), for: .touchUpInside)
		settinngsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)

	}

	@objc private func gameButtonPressed() {
		let controller = GameViewController()
		self.navigationController?.pushViewController(controller, animated: true)
	}
	@objc private func recordButtonPressed() {
		let controller = RecordsViewController()
		self.navigationController?.pushViewController(controller, animated: true)
	}
	@objc private func settingsButtonPressed() {
		let controller = SettingsViewController()
		self.navigationController?.pushViewController(controller, animated: true)
	}

}

