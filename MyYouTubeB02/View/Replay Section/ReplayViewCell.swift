//
//  ReplayViewCell.swift
//  MyYouTubeB02
//
//  Created by Marius on 27/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import UIKit

class ReplayViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var likesNumber: UILabel!
    
    // MARK: - Public Methods
    func configureCell (commentModel: CommentSnippetModel) {
        
        let profileImageUrl = commentModel.authorProfileImageUrl
        if profileImageUrl != "" { profileImage.kf.setImage(with: URL(string: profileImageUrl!)!) }
        
        channelTitle.text = commentModel.authorDisplayName
        comment.text = commentModel.textOriginal
        likesNumber.text = String(commentModel.likeCount)
    }
}
