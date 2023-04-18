//
//  PhotoListTableCell.swift
//  SnapList
//
//  Created by Pavel on 19.04.23.
//

import UIKit

final class PhotoListTableCell: UITableViewCell {
    lazy var photo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "MarkPro-Bold", size: 18)
        label.textColor = UIColor(named: "TextColor")
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "photoListTableCell")
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        self.addSubview(photo)
        self.addSubview(name)
    }

    private func makeConstraints() {
        photo.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.width.height.equalTo(100)
            $0.leading.equalTo(contentView).offset(20)
        }
        
        name.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(photo.snp.trailing).offset(10)
        }
    }
}
