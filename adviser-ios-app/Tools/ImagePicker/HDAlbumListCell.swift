//
//  HDAlbumListCell.swift
//  mgr-combat-map-ios
//
//  Created by chenwuqi on 2019/5/13.
//  Copyright © 2019 evergrande_caifu_manager. All rights reserved.
//

import UIKit

class HDAlbumListCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    
    /// 数据源
    var albumModel: HDAlbumModel? {
        didSet {
            guard let albumModel = albumModel else { return }
            name.text = albumModel.albumName
            count.text = "\(albumModel.fetchAssets.count)"
            icon.image = albumModel.coverImage
            albumModel.requestCoverImage { [weak self] (model, coverImage) in
                guard let `self` = self, self.albumModel == model else { return }
                self.icon.image = coverImage
            }
//            setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
