//
//  VideoCell.swift
//  MyYouTubeB02
//
//  Created by Marius on 21/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import UIKit
import Kingfisher

class VideoCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    // MARK: - Public Properties
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var channelImg: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var channelName: UILabel!
    
    // MARK: - Private Properties
    
    // MARK: - Overriden Methods
    
    // MARK: - IBActions
    
    // MARK: - Public Methods
    func cofifigureCell(videoModel: VideoModel, channelDetails: ChannelDetails) {
        
        //TODO - download image with Kingfisher
        let videoThumb = videoModel.snippet.thumbnail.anyResolutionUrl
        let channelThumb = channelDetails.thumbnail.anyResolutionUrl
        if videoThumb != "" { thumbImg.kf.setImage(with: URL(string: videoThumb)!) }
        if channelThumb != "" { channelImg.kf.setImage(with: URL(string: channelThumb)!) }
        videoTitle.text = videoModel.snippet.title
        channelName.text = channelDetails.title
    }
    
    // MARK: - Private Methods
    
}
// MARK: - Extensions
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
