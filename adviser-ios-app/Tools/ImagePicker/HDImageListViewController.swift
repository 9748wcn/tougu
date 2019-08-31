//
//  HXImageListViewController.swift
//  HXImagePickerController
//
//  Created by HongXiangWen on 2019/2/28.
//  Copyright © 2019年 WHX. All rights reserved.
//

import UIKit

class HDImageListViewController: UIViewController {

    /// 相册模型
    var albumModel: HDAlbumModel? {
        didSet {
            guard isViewLoaded else { return }
            title = albumModel?.albumName
            requestImageModels()
        }
    }
    
    /// 图片模型数组
    private var imageModels: [HDImageModel] = []
    
    /// 所在的导航控制器
    private weak var pickerController: HDImagePickerViewController? {
        return navigationController as? HDImagePickerViewController
    }
    
    /// 监听contentSize变化
    private var collectionViewObserver: NSKeyValueObservation?
    
    /// 标记将要滚动到底部
    private var willScrollToBottom: Bool = false
    
    /// 懒加载collectionView
    private lazy var collectionView: UICollectionView = {
        let itemSpacing: CGFloat = 5
        let itemWidth = (screenWidth - itemSpacing) / 4 - itemSpacing
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:
        screenHeight), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.hx_registerCell(cellClass: HDImageCell.self)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = albumModel?.albumName
        view.backgroundColor = .white
        view.addSubview(collectionView)
        addObserver()
        setupCancelItem()
        requestImageModels()
    }
    
    deinit {

    }
    
    private func addObserver() {
        collectionViewObserver = collectionView.observe(\.contentSize, changeHandler: { [weak self] (obj, changed) in
            guard let `self` = self else { return }
            if self.willScrollToBottom {
                self.collectionViewScrollToBottom()
            }
        })
    }
    
    private func collectionViewScrollToBottom() {
        if collectionView.contentSize.height > collectionView.frame.height {
            let offset = CGPoint(x: 0, y: collectionView.contentSize.height - collectionView.frame.height)
            collectionView.contentOffset = offset
        }
        self.willScrollToBottom = false
    }
    
    /// 加载模型
    private func requestAlbumModel() {
        HDPhotoImageManager.getPhotoLibraryAuthorization { [weak self] (success) in
            guard let `self` = self else { return }
            if success {
                DispatchQueue.global().async {
                    let albums = HDPhotoImageManager.getPhotoAlbums(with: .smartAlbum, filterEmpty: true)
                    let albumModel = HDAlbumModel(albums[0], mediaTypes: self.pickerController?.mediaTypes ?? [.image, .video])
                    DispatchQueue.main.async {
                        self.albumModel = albumModel
                    }
                }
            } else {
                self.pickerController?.showAuthorizationAlert()
            }
        }
    }
    
    private func requestImageModels() {
        if let albumModel = albumModel {
            DispatchQueue.global().async {
                var imageModels = [HDImageModel]()
                for i in 0 ..< albumModel.fetchAssets.count {
                    let phAsset = albumModel.fetchAssets[i]
                    let assetModel = HDImageModel(phAsset)
                    imageModels.append(assetModel)
                }
                DispatchQueue.main.async {
                    self.imageModels = imageModels
                    self.willScrollToBottom = true
                    self.collectionView.reloadData()
                }
            }
        } else {
            requestAlbumModel()
        }
    }
    
    private func setupCancelItem() {
        let cancelItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelItemClicked))
        navigationItem.rightBarButtonItem = cancelItem
    }
    
    @objc private func cancelItemClicked() {
        pickerController?.cancelSelect()
    }
    
    /// 切换图片选中状态
    ///
    /// - Parameter assetModel: 图片资源模型
//    private func toggleImageSelected(with imageModel: HXImageModel) {
//        guard var selectedModels = pickerController?.selectedImageModels else { return }
//        /// 设置选中状态
//        if imageModel.isSelected {
//            imageModel.selectedIndex = -1
//            if let index = selectedModels.index(of: imageModel) {
//                selectedModels.remove(at: index)
//            }
//        } else {
//            selectedModels.append(imageModel)
//        }
//        pickerController?.selectedImageModels = selectedModels
//    }

//    /// 检查是否选到最大值,设置是否可继续选择
//    private func resetCanSelectState(selectedModels: [HXImageModel]) {
//        var canSelect = true
//        if selectedModels.count == pickerController?.maxSelectCount {
//           canSelect = false
//        }
//        for i in 0 ..< imageModels.count {
//            let model = imageModels[i]
//            if !selectedModels.contains(model) {
//                model.canSelect = canSelect
//            }
//        }
//    }
//
//    private func pushToPreviewVC(imageModels: [HXImageModel], currentIndex: Int) {
//        let previewVC = HXImagePreviewViewController()
//        previewVC.imageModels = imageModels
//        previewVC.currentIndex = currentIndex
//        previewVC.imageDidEditedCallback = { [weak self] (imageModel) in
//            guard let `self` = self else { return }
//            guard let index = self.imageModels.index(of: imageModel) else { return }
//            self.imageModels.replaceSubrange(index ..< index + 1, with: [imageModel])
//            self.collectionView.reloadData()
//        }
//        navigationController?.pushViewController(previewVC, animated: true)
//    }
    
    // MARK: -  Tool View Actions
    
//    @objc private func previewBtnClicked() {
//        guard let pickerController = pickerController else { return }
//        pushToPreviewVC(imageModels: pickerController.selectedImageModels, currentIndex: 0)
//    }
//
//    @objc private func originBtnClicked() {
//        guard let pickerController = pickerController else { return }
//        pickerController.isOrigin = !pickerController.isOrigin
//    }
//
//    @objc private func confirmBtnClicked() {
//        pickerController?.confirmSelectImageModels()
//    }
    
}

// MARK: -  UICollectionViewDataSource, UICollectionViewDelegate
extension HDImageListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.hx_dequeueReusableCell(indexPath: indexPath) as HDImageCell
//        cell.mainTintColor = pickerController?.mainTintColor ?? .red
        cell.imageModel = imageModels[indexPath.item]
//        cell.selectBtnClickedCallback = { [weak self] (imageCell) in
//            guard let `self` = self, let imageModel = imageCell.imageModel else { return }
//            self.toggleImageSelected(with: imageModel)
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageModel = imageModels[indexPath.item]
        pickerController?.didSelectedImageModel(imageModel: imageModel)
    }
    
}
