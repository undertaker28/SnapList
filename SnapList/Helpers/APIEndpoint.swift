//
//  APIService.swift
//  SnapList
//
//  Created by Pavel on 18.04.23.
//

import Foundation

enum Endpoint {
    static let baseURL = URL(string: "https://junior.balinasoft.com/api/v2/")!
    
    case loadPhotoGETRequest(Int)
    case sendPhotoPOSTRequest
    
    var url: URL {
        switch self {
        case .loadPhotoGETRequest(let page):
            let queryItems = [URLQueryItem(name: "page", value: "\(page)")]
            var loadPhotoURL = URLComponents(url: Endpoint.baseURL.appendingPathComponent("photo/type"), resolvingAgainstBaseURL: true)!
            loadPhotoURL.queryItems = queryItems
            return loadPhotoURL.url ?? Endpoint.baseURL
        case .sendPhotoPOSTRequest:
            return Endpoint.baseURL.appendingPathComponent("photo")
        }
    }
}
