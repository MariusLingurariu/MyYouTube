//
//  Snippet.swift
//  MyYouTubeB02
//
//  Created by Marius on 21/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import Foundation
import SwiftyJSON

class Snippet {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private(set) var channelId: String!
    private(set) var description: String!
    private(set) var thumbnail: Thumbnails
    private(set) var channelTitle: String!
    private(set) var title: String!

    
    // MARK: - Initializer
    init() {
        channelId = ""
        description = ""
        title = ""
        thumbnail = Thumbnails()
        channelTitle = ""
    }
    
    init(json: JSON){
        channelId = json["channelId"].stringValue
        description = json["description"].stringValue
        channelTitle = json["channelTitle"].stringValue
        title = json["title"].stringValue
        print(json["thumbnails"].stringValue)
        thumbnail = Thumbnails(json: json["thumbnails"])
    }
}
