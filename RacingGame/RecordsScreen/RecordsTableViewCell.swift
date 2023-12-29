//
//  RecordsTableViewCell.swift
//  RacingGame
//
//  Created by Кирилл Курилюк on 28.12.2023.
//

import UIKit
import SnapKit

private extension CGFloat {
	static let offset: CGFloat = 16
}

class RecordsTableViewCell: UITableViewCell {
	
	static var identifier: String { "\(Self.self)"}
	
	private let usernameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 20.0)
		label.numberOfLines = 0
		
		return label
	}()
	private let userRecordLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 20.0)
		label.numberOfLines = 0
		
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(usernameLabel)
		contentView.addSubview(userRecordLabel)
		usernameLabel.snp.makeConstraints { make in
			make.left.top.equalToSuperview().offset(CGFloat.offset)
			make.bottom.equalToSuperview().inset(CGFloat.offset)
			make.right.equalToSuperview().inset(60)

		}
		userRecordLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(CGFloat.offset)
			make.right.equalToSuperview().inset(CGFloat.offset)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		usernameLabel.text = nil
		userRecordLabel.text = nil
	}
	
	func configure(with model: RecordCellModel, handler: @escaping (String?) -> Void) {
		usernameLabel.text = model.name
		userRecordLabel.text = "\(model.record)"
	}
}
