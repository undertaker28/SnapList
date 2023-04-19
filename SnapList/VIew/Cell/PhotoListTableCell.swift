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
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "photoListTableCell")
        self.add(subviews: photo, name)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        photo.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(100)
            $0.leading.equalToSuperview().inset(20)
        }

        name.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(photo.snp.trailing).offset(15)
        }
    }
}
