//
//  CommentCell.swift
//  MyYouTubeB02
//
//  Created by Marius on 27/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var likesNumber: UILabel!
    @IBOutlet weak var repliesNumber: UILabel!
    @IBOutlet weak var viewRepliesLbl: UILabel!
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - IBActions
    
    // MARK: - Public Methods
    func configureCell (commentModel: CommentModel) {
        switch commentModel.totalReplyCount.hashValue {
        case 1:
            viewRepliesLbl.text = "VIEW REPLY"
        case 0 :
            viewRepliesLbl.text = ""
        default:
            viewRepliesLbl.text = "VIEW \(commentModel.totalReplyCount.hashValue) REPLIES"
        }
        
        let profileImageUrl = commentModel.commentSnippet.authorProfileImageUrl
        if profileImageUrl != "" { profileImage.kf.setImage(with: URL(string: profileImageUrl!)!) }
        
        channelTitle.text = commentModel.commentSnippet.authorDisplayName
        comment.text = commentModel.commentSnippet.textOriginal
        likesNumber.text = String(commentModel.commentSnippet.likeCount)
        repliesNumber.text = "\(commentModel.totalReplyCount.hashValue)"
    }
    
    // MARK: - Private Methods

    
}
