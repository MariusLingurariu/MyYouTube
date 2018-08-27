//
//  CommentSnippetModel.swift
//  MyYouTubeB02
//
//  Created by Marius on 27/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import Foundation
import SwiftyJSON

class CommentSnippetModel {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private(set) var authorDisplayName: String!
    private(set) var authorProfileImageUrl: String!
    private(set) var textOriginal: String!
    private(set) var likeCount: Int!
    
    // MARK: - Public Methods
    init() {
        authorDisplayName = ""
        authorProfileImageUrl = ""
        textOriginal = ""
        likeCount = 0
    }
    
    init(json: JSON) {
        authorDisplayName = json["authorDisplayName"].stringValue
        authorProfileImageUrl = json["authorProfileImageUrl"].stringValue
        textOriginal = json["textOriginal"].stringValue
        likeCount = json["likeCount"].intValue
    }
    
    // MARK: - Private Methods
    
    
}
