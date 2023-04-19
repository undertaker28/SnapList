//
//  PhotoListViewController.swift
//  SnapList
//
//  Created by Pavel on 18.04.23.
//

import UIKit
import SnapKit

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
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Photos"
        view.add(subviews: tableView)
        makeConstraints()
        loadPhotos(page: 0)
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    private func loadPhotos(page: Int) {
        Task {
            networkService.loadPhoto(url: Endpoint.loadPhotoGETRequest(page).url, completion: { result in
                guard let result = result else { return }
                self.currentPhotoType = result
                self.photos.append(contentsOf: self.currentPhotoType?.content ?? [])
                self.tableView.reloadData()
            })
        }
    }
    
    private func sendPhoto(sendData: SendPhoto) {
        Task {
            networkService.sendPhoto(url: Endpoint.sendPhotoPOSTRequest.url, sendData: sendData)
        }
    }
    
    private func showCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension PhotoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPhoto = photos[indexPath.row]
        if ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil {
            print("Simulator")
        } else {
            showCamera()
        }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoListTableCell", for: indexPath) as? PhotoListTableCell else {
            fatalError("Unable to dequeue PhotoListTableCell")
        }
        
        cell.backgroundColor = UIColor(named: "BackgroundColor")
        
        if let photoStringURL = photos[indexPath.row].image {
            cell.photo.URLImage(url: URL(string: photoStringURL)!)
        } else {
            cell.photo.image = UIImage(systemName: "photo")
            cell.photo.tintColor = .lightGray
        }
        
        cell.name.text = photos[indexPath.row].name
        
        return cell
    }
}

extension PhotoListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else { return }
        let sendData = SendPhoto(id: selectedPhoto.id, developer: Constants.developerName, image: image)
        
        sendPhoto(sendData: sendData)
    }
}
