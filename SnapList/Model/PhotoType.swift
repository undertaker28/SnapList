//
//  PhotoType.swift
//  SnapList
//
//  Created by Pavel on 18.04.23.
//

import Foundation

struct PhotoType: Codable {
    let page: Int
    let totalPages: Int
    let content: [Photo]
}
