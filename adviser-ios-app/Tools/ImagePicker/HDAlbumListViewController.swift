//
//  HXAlbumListViewController.swift
//  HXImagePickerController
//
//  Created by HongXiangWen on 2019/2/28.
//  Copyright © 2019年 WHX. All rights reserved.
//

import UIKit

class HDAlbumListViewController: UIViewController {

    /// 懒加载tableView
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.hx_registerCell(cellClass: HDAlbumListCell.self)
//        tableView.register(HDAlbumCell.self, forCellReuseIdentifier:"HXAlbumCell")
        return tableView
    }()
    
    /// 数据源
    private var albums: [HDAlbumModel] = []
    
    /// 所在的导航控制器
    private weak var pickerController: HDImagePickerViewController? {
        return navigationController as? HDImagePickerViewController
    }
        
    deinit {
//        HXLog("HXAlbumListViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 设置属性
        title = "照片"
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupCancelItem()
        requestAlbumModels()
    }
    
    private func requestAlbumModels() {
        HDPhotoImageManager.getPhotoLibraryAuthorization { [weak self] (success) in
            guard let `self` = self else { return }
            if success {
                DispatchQueue.global().async {
                    let photoAlbums = HDPhotoImageManager.getPhotoAlbums()
                    var albumModels = [HDAlbumModel]()
                    for assetCollection in photoAlbums {
                        let albumModel = HDAlbumModel(assetCollection, mediaTypes: self.pickerController?.mediaTypes ?? [.image, .video])
                        albumModels.append(albumModel)
                    }
                    DispatchQueue.main.async {
                        self.albums = albumModels
                        self.tableView.reloadData()
                    }
                }
            } else {
                self.pickerController?.showAuthorizationAlert()
            }
        }
    }
    
    /// 取消
    private func setupCancelItem() {
        let cancelItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelItemClicked))
        navigationItem.rightBarButtonItem = cancelItem
    }
    
    @objc private func cancelItemClicked() {
        pickerController?.cancelSelect()
    }
    
    /// 跳转到照片列表页
    ///
    /// - Parameters:
    ///   - albumModel: 相册模型
    ///   - animated: 是否跳转动画
    private func pushToImageListVC(albumModel: HDAlbumModel?, animated: Bool) {
        let imageListVC = HDImageListViewController()
        imageListVC.albumModel = albumModel
        navigationController?.pushViewController(imageListVC, animated: animated)
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HDAlbumListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as HDAlbumListCell
        cell.albumModel = albums[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        pushToImageListVC(albumModel: albums[indexPath.row], animated: true)
    }
    
}
