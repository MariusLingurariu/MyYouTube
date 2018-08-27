//
//  SugestedVideoCell.swift
//  MyYouTubeB02
//
//  Created by Marius on 24/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import Foundation
import Kingfisher

class SugestedVideoCell: UITableViewCell {
    // MARK: - IBOutlets
    
    @IBOutlet weak var videoThumbImg: UIImageView!
    @IBOutlet weak var videoDurationLbl: UILabel!
    @IBOutlet weak var videoTitleLbl: UILabel!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var viewsNumberLbl: UILabel!
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - Overriden Methods
    
    // MARK: - IBActions
    
    // MARK: - Public Methods
    func configureCell(videoModel: VideoModel) {
        let videoThumb = videoModel.snippet.thumbnail.anyResolutionUrl
        if videoThumb != "" { videoThumbImg.kf.setImage(with: URL(string: videoThumb)!)}
        videoTitleLbl.text = videoModel.snippet.title
        channelNameLbl.text = videoModel.snippet.channelTitle
    }
    
    // MARK: - Private Methods
}
