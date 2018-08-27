//
//  Comment Model.swift
//  MyYouTubeB02
//
//  Created by Marius on 27/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import Foundation
import SwiftyJSON

class CommentModel {
    // MARK: - Private Properties
    private(set) var commentId: String!
    private(set) var videoId: String!
    private(set) var totalReplyCount: Int!
    private(set) var commentSnippet: CommentSnippetModel
    private(set) var replies: RepliesModel
    // MARK: - Public Methods
    init() {
        commentId = ""
        videoId = ""
        totalReplyCount = 0
        commentSnippet = CommentSnippetModel()
        replies = RepliesModel()
    }
    
    init(json: JSON) {
        commentId = json["id"].stringValue
        videoId = json["snippet"]["videoId"].stringValue
        totalReplyCount = json["snippet"]["totalReplyCount"].intValue
        commentSnippet = CommentSnippetModel(json: json["snippet"]["topLevelComment"]["snippet"])
        replies = RepliesModel(json: json["replies"])
    }
}
