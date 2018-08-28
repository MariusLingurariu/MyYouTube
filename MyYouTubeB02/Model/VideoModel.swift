//
//  VideoModel.swift
//  MyYouTube
//
//  Created by Marius on 16/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import Foundation
import SwiftyJSON

class VideoModel {
    
    // MARK: - Private Properties
    private var _videoId: String!
    
    private var _snippet: Snippet
    
    // MARK: - Public Properties
    var videoId: String {
        set { _videoId = newValue }
        get {
            if _videoId == nil {
                _videoId = ""
            }
            return _videoId
        }
    }
    
    
    
    var snippet: Snippet {
        return _snippet
    }
    
    
    // MARK: - Initializer
    init() {
        _videoId = ""
        _snippet = Snippet()
    }
    
    init(json: JSON) {
        if json["id"].stringValue != "" {
            _videoId = json["id"].stringValue
        } else {
            _videoId = json["id"]["videoId"].stringValue
        }
        
        _snippet = Snippet(json: json["snippet"])
    }
}
