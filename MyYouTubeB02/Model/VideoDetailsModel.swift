//
//  VideoDetailsModel.swift
//  MyYouTubeB02
//
//  Created by Marius on 23/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import Foundation
import SwiftyJSON

class VideoDetailsModel {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private(set) var snippet: Snippet
    private(set) var viewCount: String!
    private(set) var likeCount: String!
    private(set) var dislikeCount: String!
    private(set) var commentCount: String!
    
    // MARK: - Public Methods
    init() {
        snippet = Snippet()
        viewCount = ""
        likeCount = ""
        dislikeCount = ""
        commentCount = ""
    }
    
    init(json: JSON) {
        snippet = Snippet(json: json["snippet"])
        viewCount = json["statistics"]["viewCount"].stringValue
        likeCount = json["statistics"]["likeCount"].stringValue
        dislikeCount = json["statistics"]["dislikeCount"].stringValue
        commentCount = json["statistics"]["commentCount"].stringValue
    }
    
    // MARK: - Private Methods
    
}
