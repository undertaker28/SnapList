//
//  UIImageView+Ex.swift
//  SnapList
//
//  Created by Pavel on 19.04.23.
//

import UIKit
import Alamofire

extension UIImageView {
    func URLImage(url: URL) {
        self.image = UIImage(systemName: "photo")
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success(let data):
                    guard let imageData = data else { return }
                    self.image = UIImage(data: imageData)
                case .failure(let error):
                    print("Error fetching image: \(error)")
                }
            }
    }
}
