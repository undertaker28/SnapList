//
//  UIView+Ex.swift
//  SnapList
//
//  Created by Pavel on 19.04.23.
//

import UIKit

extension UIView {
    func add(subviews: UIView...) {
        for subview in subviews {
            self.addSubview(subview)
        }
    }
}
