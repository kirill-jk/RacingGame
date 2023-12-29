//
//  SettingsViewController.swift
//  RacingGame
//
//  Created by Кирилл Курилюк on 25.12.2023.
//
import SnapKit
import UIKit
import Photos
import PhotosUI

class SettingsViewController: UIViewController {

	let settings = UserDefaults.standard.value(User.self, forKey: "UserKey")
	let storageManager = StorageManager()

	//MARK: - UI elements
	private lazy var userImage = UIImageView()
	private let takePhotoButton = UIButton(type: .system)
	private let selectImageButton = UIButton(type: .system)
	private lazy var nameLabel = UILabel()
	private var userNameTextField = UITextField()
	private var carLabel = UILabel()
	private lazy var carChoiceSegmnet = UISegmentedControl(items: ["Default", "Race", "Cube"])
	private var settingsLabel = UILabel()
	private lazy var settingsSegmnet = UISegmentedControl(items: ["Default", "Sand", "Cube"])
	private var difficultyLabel =  UILabel()
	private lazy var difficultyChoiceSegmnet = UISegmentedControl(items: ["Easy", "Medium", "Hard"])
	private let saveButton = UIButton(type: .system)
	
	//MARK: - let/var
	private var nameOfTheImage = ""
	
	//MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		userNameTextField.delegate = self
		setupUI()
    }
	
	//MARK: - UI
	private func setupUI() {
		view.backgroundColor = #colorLiteral(red: 0.6668561101, green: 0.889429152, blue: 0.9271188378, alpha: 1)
		nameOfTheImage = settings?.picture ?? "defaultPhoto"
		userImage.contentMode = .scaleAspectFill
		userImage.layer.cornerRadius = 50
		userImage.layer.borderWidth = 2.0
		userImage.layer.borderColor = UIColor.black.cgColor
		userImage.layer.masksToBounds = false
		userImage.clipsToBounds = true
		userImage.translatesAutoresizingMaskIntoConstraints = false
		if let loadedImage = storageManager.loadImage(withName: nameOfTheImage) {
			userImage.image = loadedImage
		} else {
			let image = UIImage(named: "defaultPhoto")
			userImage.image = image
		}
		view.addSubview(userImage)
		
		
		selectImageButton.translatesAutoresizingMaskIntoConstraints = false
		selectImageButton.setTitle("Select photo", for: .normal)
		selectImageButton.setTitleColor(.white, for: .normal)
		selectImageButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
		selectImageButton.layer.cornerRadius = 10
		selectImageButton.titleLabel?.numberOfLines = 0
		selectImageButton.addTarget(self, action: #selector(loadImageButtonPressed), for: .touchUpInside)
		view.addSubview(selectImageButton)
		
		takePhotoButton.translatesAutoresizingMaskIntoConstraints = false
		takePhotoButton.setTitle("Take photo", for: .normal)
		takePhotoButton.setTitleColor(.white, for: .normal)
		takePhotoButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
		takePhotoButton.layer.cornerRadius = 10
		takePhotoButton.titleLabel?.numberOfLines = 0
		takePhotoButton.addTarget(self, action: #selector(takePhotoButtonPressed), for: .touchUpInside)
		view.addSubview(takePhotoButton)
		
		
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.text = settings?.userName ?? "NoName"
		nameLabel.textColor = .black
		nameLabel.font = UIFont.systemFont(ofSize: 25)
		nameLabel.numberOfLines = 0
		view.addSubview(nameLabel)
		
		userNameTextField.translatesAutoresizingMaskIntoConstraints = false
		userNameTextField.placeholder = "Type your name here"
		userNameTextField.textColor = .white
		userNameTextField.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 0.41)
		userNameTextField.font = UIFont.systemFont(ofSize: 17)
		view.addSubview(userNameTextField)
		
		carLabel.translatesAutoresizingMaskIntoConstraints = false
		carLabel.textColor = .black
		carLabel.text = "Choose your car"
		carLabel.numberOfLines = 0
		view.addSubview(carLabel)
		
		carChoiceSegmnet.translatesAutoresizingMaskIntoConstraints = false
		carChoiceSegmnet.selectedSegmentIndex = settings?.car ?? 0
		view.addSubview(carChoiceSegmnet)
		
		settingsLabel.translatesAutoresizingMaskIntoConstraints = false
		settingsLabel.text = "Choose background"
		settingsLabel.textColor = .black
		settingsLabel.numberOfLines = 0
		view.addSubview(settingsLabel)
		
		settingsSegmnet.translatesAutoresizingMaskIntoConstraints = false
		settingsSegmnet.selectedSegmentIndex = settings?.background ?? 0
		view.addSubview(settingsSegmnet)
		
		difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
		difficultyLabel.text = "Choose difficulty"
		difficultyLabel.textColor = .black
		difficultyLabel.numberOfLines = 0
		view.addSubview(difficultyLabel)
		
		difficultyChoiceSegmnet.translatesAutoresizingMaskIntoConstraints = false
		difficultyChoiceSegmnet.selectedSegmentIndex = settings?.difficulty ?? 0
		view.addSubview(difficultyChoiceSegmnet)
		
		saveButton.translatesAutoresizingMaskIntoConstraints = false
		saveButton.setTitle("Save settings", for: .normal)
		saveButton.setTitleColor(.white, for: .normal)
		saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 21)
		saveButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
		saveButton.layer.cornerRadius = 10
		saveButton.titleLabel?.numberOfLines = 0
		saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
		view.addSubview(saveButton)
		
		userImage.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(50)
			make.centerX.equalToSuperview()
			make.width.height.equalTo(100)
		}
		
		selectImageButton.snp.makeConstraints { make in
			make.top.equalTo(userImage).offset(100)
			make.left.equalToSuperview().offset(50)
		}
		takePhotoButton.snp.makeConstraints { make in
			make.top.equalTo(userImage).offset(100)
			make.right.equalToSuperview().inset(50)
		}
		
		nameLabel.snp.makeConstraints { make in
			make.top.equalTo(selectImageButton).offset(50)
			make.left.equalToSuperview().offset(50)
		}
		
		userNameTextField.snp.makeConstraints { make in
			make.top.equalTo(nameLabel).offset(40)
			make.left.equalToSuperview().offset(50)
			make.right.equalToSuperview().inset(50)
		}
		
		carLabel.snp.makeConstraints { make in
			make.top.equalTo(userNameTextField).offset(50)
			make.left.equalToSuperview().offset(50)
		}
		
		carChoiceSegmnet.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(50)
			make.right.equalToSuperview().inset(50)
			make.top.equalTo(carLabel).offset(25)
			make.height.equalTo(40)
		}
		
		settingsLabel.snp.makeConstraints { make in
			make.top.equalTo(carChoiceSegmnet).offset(75)
			make.left.equalToSuperview().offset(50)
		}
		
		settingsSegmnet.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(50)
			make.right.equalToSuperview().inset(50)
			make.top.equalTo(settingsLabel).offset(25)
			make.height.equalTo(40)
		}
		
		difficultyLabel.snp.makeConstraints { make in
			make.top.equalTo(settingsSegmnet).offset(75)
			make.left.equalToSuperview().offset(50)
		}
		
		difficultyChoiceSegmnet.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(50)
			make.right.equalToSuperview().inset(50)
			make.top.equalTo(difficultyLabel).offset(25)
			make.height.equalTo(40)
		}
		
		saveButton.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.bottom.equalToSuperview().inset(70)
			make.height.equalTo(40)
			make.width.equalTo(150)
		}
	}
	

	//MARK: - Actions
	@objc private func takePhotoButtonPressed() {
		let vc = UIImagePickerController()
		vc.sourceType = .camera
		vc.delegate = self
		vc.allowsEditing = true
		present(vc, animated: true)
	}
	
	@objc private func loadImageButtonPressed() {
		var config = PHPickerConfiguration(photoLibrary: .shared())
		config.selectionLimit = 1
		config.filter = .images
		let PHPickerVC = PHPickerViewController(configuration: config)
		PHPickerVC.delegate = self
		present(PHPickerVC, animated: true)
		}
	
	@objc private func saveButtonPressed() {
		if userNameTextField.text != "" {
			nameLabel.text = userNameTextField.text
		}
		
		let userSettings = User(picture: nameOfTheImage, userName: nameLabel.text!, car: carChoiceSegmnet.selectedSegmentIndex, background: settingsSegmnet.selectedSegmentIndex, difficulty: difficultyChoiceSegmnet.selectedSegmentIndex)
		UserDefaults.standard.set(userSettings, forKey: "UserKey")
		userNameTextField.endEditing(true)
		navigationController?.popViewController(animated: true)
	}
}

//MARK: - UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		nameLabel.text = textField.text
		textField.endEditing(true)
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		userNameTextField.text = ""
	}
}


//MARK: - UIImagePickerControllerDelegate

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
			userImage.image = image
			if let saveImage = userImage.image {
				do {
					if let imageName = try storageManager.saveImage(saveImage) {
						nameOfTheImage = imageName
						if let loadedImage = storageManager.loadImage(withName: imageName) {
							userImage.image = loadedImage
						}
					}
				} catch {
					print("Ошибка при сохранении изображения: \(error.localizedDescription)")
				}
			}
		}
		picker.dismiss(animated: true)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true)
	}
}

extension SettingsViewController: PHPickerViewControllerDelegate {
	func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
		picker.dismiss(animated: true, completion: .none)
		results.forEach { result in
			result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
				guard let image = reading as? UIImage, error == nil else { return }
				DispatchQueue.main.async {
					self.userImage.image = image
					if let saveImage = self.userImage.image {
						do {
							if let imageName = try self.storageManager.saveImage(saveImage) {
								self.nameOfTheImage = imageName
								if let loadedImage = self.storageManager.loadImage(withName: imageName) {
									self.userImage.image = loadedImage
								}
							}
						} catch {
							print("Ошибка при сохранении изображения: \(error.localizedDescription)")
						}
					}
				}
			}
		}
	}
}
