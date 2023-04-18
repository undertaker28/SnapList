//
//  APIService.swift
//  SnapList
//
//  Created by Pavel on 18.04.23.
//

import Foundation

enum Endpoint {
    static let baseURL = URL(string: "https://junior.balinasoft.com/api/v2/")!
    
    case loadPhotoGETRequest
    case sendPhotoPOSTRequest
    
    var url: URL {
        switch self {
        case .loadPhotoGETRequest:
            return Endpoint.baseURL.appendingPathComponent("photo/type")
        case .sendPhotoPOSTRequest:
            return Endpoint.baseURL.appendingPathComponent("photo")
        }
    }
}
