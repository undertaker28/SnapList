//
//  PhotoService.swift
//  SnapList
//
//  Created by Pavel on 18.04.23.
//

import Alamofire

final class NetworkService {
    func loadPhoto(url: URL, completion: @escaping (PhotoType?) -> Void) {
        AF.request(url, method: .get)
        .validate(statusCode: 200..<300)
        .responseData() { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(PhotoType.self, from: data)
                    completion(result)
                } catch {
                    completion(nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func sendPhoto(url: URL, sendData: SendPhoto) {
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
        guard let imageData = sendData.image.jpegData(compressionQuality: 0.5) else {
            print("Error: image data couldn't be retrieved.")
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(sendData.developer.utf8), withName: "name")
            multipartFormData.append(imageData, withName: "photo", fileName: "\(sendData.id).jpeg", mimeType: "image/jpeg")
            multipartFormData.append(Data("\(sendData.id)".utf8), withName: "typeId")
        }, to: url, method: .post, headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ServerResponse.self) { response in
            switch response.result {
            case .success(let data):
                print(data.id)
            case .failure(let error):
                print(error)
            }
        }
    }
}
