//
//  GameViewController.swift
//  RacingGame
//
//  Created by Кирилл Курилюк on 25.12.2023.
//

import UIKit

class GameViewController: UIViewController {
	
	private lazy var carImageView = UIImageView()
	private lazy var obstacleImageView1 = UIImageView()
	private lazy var obstacleImageView2 = UIImageView()
	private lazy var scoreLabel = UILabel()
	private let backgroundImage = UIImageView()
	
	var gameTimer: Timer?
	let leftBoundary: CGFloat = 30
	let rightBoundary: CGFloat = UIScreen.main.bounds.width - 30
	private var score = 0
	private var userName = ""
	private var hardness = 0.008
	private var userCarImageName = ""
	private var backgroundColor = UIColor()
	private var obstacleImageName = ""
	private var backgroundImageName = ""
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

		let settingsUI = UserDefaults.standard.value(User.self, forKey: "UserKey")
		let gameSettings = GameSettingsModel(userName: settingsUI?.userName ?? "NoName", hardness: settingsUI?.difficulty ?? 2, userCar: settingsUI?.car ?? 0, backgroundStyle: settingsUI?.background ?? 0)
		userName = gameSettings.userName
		hardness = gameSettings.hardness
		userCarImageName = gameSettings.userCar
		backgroundColor = gameSettings.backgroundColor
		obstacleImageName = gameSettings.obstacles
		backgroundImageName = gameSettings.backgroundStyle
		setupUI()
		
		
		startGame()
	}
	func setupUI() {
		view.backgroundColor = backgroundColor
		backgroundImage.image = UIImage(named: backgroundImageName)
		backgroundImage.contentMode = .scaleToFill
		backgroundImage.frame = CGRect(x: 30, y: 0, width: view.bounds.width - 60, height: view.bounds.height)
		backgroundImage.layer.borderColor = UIColor.black.cgColor
		view.addSubview(backgroundImage)
		
		scoreLabel.text = "Score: \(score)"
		scoreLabel.font = UIFont.systemFont(ofSize: 20)
		scoreLabel.numberOfLines = 0
		scoreLabel.textColor = .white
		scoreLabel.layer.cornerRadius = 10
		scoreLabel.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
		scoreLabel.layer.masksToBounds = true
		scoreLabel.frame = CGRect(x: view.bounds.midX - 30, y: 50, width: 60, height: 60)

		view.addSubview(scoreLabel)
	}
	
	func startGame() {
		score = 0
		scoreLabel.text = "Score: \(score)"
		gameTimer?.invalidate()
		let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
		view.addGestureRecognizer(swipeGesture)
		
		let userCarImage = UIImage(named: userCarImageName)
		let obstacleImage = UIImage(named: obstacleImageName)
		let widthSizeForImage = view.bounds.width/5
		let heightSizeForImage = view.bounds.height/5
		
		carImageView = UIImageView(image: userCarImage)
		carImageView.frame = CGRect(x: 0, y: 0, width: widthSizeForImage, height: heightSizeForImage)
		carImageView.center = CGPoint(x: view.bounds.midX, y: view.bounds.height - 100)
		view.addSubview(carImageView)

		
		obstacleImageView1 = UIImageView(frame: CGRectMake(0, 0, widthSizeForImage, heightSizeForImage))
		obstacleImageView1.image = obstacleImage
		obstacleImageView1.center = CGPoint(x: view.bounds.midX - 50, y: CGFloat(-100))
		view.addSubview(obstacleImageView1)
		
		
		obstacleImageView2 = UIImageView(frame: CGRectMake(0, 0, widthSizeForImage, heightSizeForImage))
		obstacleImageView2.image = obstacleImage
		obstacleImageView2.center = CGPoint(x: view.bounds.midX + 50, y: CGFloat(-600))
		view.addSubview(obstacleImageView2)

		gameTimer = Timer.scheduledTimer(timeInterval: hardness, target: self, selector: #selector(moveObstacle), userInfo: nil, repeats: true)
		}
	
	@objc func handlePan(_ gesture: UIPanGestureRecognizer) {
		let translation = gesture.translation(in: view)
		carImageView.center.x += translation.x
		gesture.setTranslation(CGPoint.zero, in: view)
	}
	
	@objc func moveObstacle() {
		obstacleImageView1.center.y += 1
		obstacleImageView2.center.y += 1
		if carImageView.frame.origin.x < leftBoundary || carImageView.frame.origin.x + carImageView.frame.width > rightBoundary {
			  gameOver()
		   }
		if obstacleImageView1.frame.intersects(carImageView.frame) || obstacleImageView2.frame.intersects(carImageView.frame) {
			gameOver()
		}
		if obstacleImageView1.frame.origin.y > view.frame.height {
			obstacleImageView1.center = generateRandomPosition()
			score += 1
			scoreLabel.text = "Score: \(score)"
		}
		if obstacleImageView2.frame.origin.y > view.frame.height {
			obstacleImageView2.center = generateRandomPosition()
			score += 1
			scoreLabel.text = "Score: \(score)"
			
		}
	}
	
	func generateRandomPosition() -> CGPoint {
		let randomX = CGFloat.random(in: 50...(view.frame.width - 50))
		return CGPoint(x: randomX, y: CGFloat(-100))
	}
	
	func gameOver() {
		updateRecords()
		gameTimer?.invalidate()
		carImageView.isHidden = true
		obstacleImageView1.isHidden = true
		obstacleImageView2.isHidden = true
		handleGameOver()
	}
	func updateRecords() {
		let recordsData = UserDefaults.standard.value(Records.self, forKey: "RecordsKey")
		let userRecords = Records()
		let record = Record(name: userName, record: score)
		userRecords.records = recordsData?.records ?? [record]
		userRecords.addRecord(record)
		UserDefaults.standard.set(userRecords, forKey: "RecordsKey")
	}

	func handleGameOver() {
		let alert = UIAlertController(title: "Game Over", message: "Your score: \(score)", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Back to menu", style: .default) { _ in
			self.navigationController?.popViewController(animated: true)
		})
		alert.addAction(UIAlertAction(title: "Start New Game", style: .default) { _ in
			self.startGame()
		})
		present(alert, animated: true, completion: nil)
	}

}
