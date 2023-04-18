//
//  ViewController.swift
//  SnapList
//
//  Created by Pavel on 18.04.23.
//

import UIKit
import SnapKit

//class ViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .purple
//        Task {
//            NetworkService().loadPhoto(url: Endpoint.loadPhotoGETRequest(0).url, completion: { (result) in
//                guard let result = result else { return }
//                print(result)
//            })
//        }
//        print(Endpoint.sendPhotoPOSTRequest.url)
//        let sendData = SendPhoto(id: 1, developer: "", image: UIImage(named: "Test")!)
//        print(sendData)
//        Task {
//            NetworkService().sendPhoto(url: Endpoint.sendPhotoPOSTRequest.url, sendData: sendData)
//        }
//    }
//}

import UIKit

final class PhotoListViewController: UIViewController {
    private var photos: [Photo] = []
    private var currentPhotoType: PhotoType!
    private var networkService = NetworkService()
    private var selectedPhoto: Photo!

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotoListTableCell.self, forCellReuseIdentifier: "photoListTableCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 120
        tableView.backgroundColor = UIColor(named: "BackgroundColor")
        tableView.tableHeaderView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Photos"
        addSubviews()
        makeConstraints()
        loadPhotos(page: 0)
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    private func loadPhotos(page: Int) {
        Task {
            NetworkService().loadPhoto(url: Endpoint.loadPhotoGETRequest(0).url, completion: { (result) in
                guard let result = result else { return }
                self.currentPhotoType = result
                self.photos.append(contentsOf: self.currentPhotoType?.content ?? [])
                self.tableView.reloadData()
            })
        }
    }
}

extension PhotoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(photos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if currentPhotoType.page < currentPhotoType.totalPages && indexPath.row == photos.count - 1 {
            loadPhotos(page: currentPhotoType.page + 1)
        }
    }
}

extension PhotoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoListTableCell", for: indexPath) as! PhotoListTableCell
        
        if let photoStringUrl = photos[indexPath.row].image {
            // TODO: - Recieve image from service
            cell.photo.image = UIImage(systemName: "photo")
        } else {
            cell.photo.image = UIImage(systemName: "photo")
            cell.photo.tintColor = UIColor.gray
        }
        
        cell.name.text = photos[indexPath.row].name

        return cell
    }
}
