//
//  ChannelDetails.swift
//  MyYouTubeB02
//
//  Created by Marius on 22/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import Foundation
import SwiftyJSON

class ChannelDetails {
    // MARK: - Private Properties
    private(set) var title: String!
    private(set) var description: String!
    private(set) var thumbnail: Thumbnails
    
    // MARK: - Public Methods
    init(){
        title = ""
        description = ""
        thumbnail = Thumbnails()
    }
    
    init(json: JSON) {
        title = json["snippet"]["title"].stringValue
        description = json["snippet"]["description"].stringValue
        thumbnail = Thumbnails(json: json["snippet"]["thumbnails"])
    }
    // MARK: - Private Methods
}
