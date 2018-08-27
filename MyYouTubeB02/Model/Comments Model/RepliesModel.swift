//
//  RepliesModel.swift
//  MyYouTubeB02
//
//  Created by Marius on 27/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import Foundation
import SwiftyJSON

class RepliesModel {
    // MARK: - Private Properties
    private(set) var replies: [CommentSnippetModel] = []
    
    // MARK: - Public Methods
    init() {
        replies = []
    }
    
    init(json: JSON) {
        if let arrayJson = JSON(json["comments"]).array {
            for item in arrayJson {
                let commentModel = CommentSnippetModel(json: item)
                replies.append(commentModel)
            }
        }
    }
    
}
