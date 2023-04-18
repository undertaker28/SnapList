//
//  ViewController.swift
//  SnapList
//
//  Created by Pavel on 18.04.23.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        Task {
            NetworkService().loadPhoto(url: Endpoint.loadPhotoGETRequest(0).url, completion: { (result) in
                guard let result = result else { return }
                print(result)
            })
        }
        print(Endpoint.sendPhotoPOSTRequest.url)
        let sendData = SendPhoto(id: 1, developer: "", image: UIImage(named: "Test")!)
        print(sendData)
        Task {
            NetworkService().sendPhoto(url: Endpoint.sendPhotoPOSTRequest.url, sendData: sendData)
        }
    }
}
