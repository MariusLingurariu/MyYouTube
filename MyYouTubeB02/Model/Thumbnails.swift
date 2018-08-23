//
//  Thumbnails.swift
//  MyYouTubeB02
//
//  Created by Marius on 21/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import Foundation
import SwiftyJSON

class Thumbnails {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private(set) var defaultUrl: String!
    private(set) var mediumUrl: String!
    private(set) var highUrl: String!
    private(set) var standardUrl: String!
    private(set) var maxResUrl: String!
    
//    private(set) var idol: String = ""
    
    var anyResolutionUrl: String {
        if maxResUrl != "" {
            return maxResUrl
        } else if highUrl != "" {
            return highUrl
        } else if mediumUrl != "" {
            return mediumUrl
        } else if standardUrl != "" {
            return standardUrl
        } else {
            return defaultUrl
        }
    }
    
    
    init(){
        defaultUrl = ""
        mediumUrl = ""
        highUrl = ""
        standardUrl = ""
        maxResUrl = ""
    }
    
    init(json: JSON){
        defaultUrl = json["default"]["url"].stringValue
        mediumUrl = json["medium"]["url"].stringValue
        
        let high = json["high"]
        highUrl = high["url"].stringValue
        
        let standard = json["standard"]
        standardUrl = standard["url"].stringValue
        
        let max = json["maxres"]
        maxResUrl = max["url"].stringValue
    }
    
    // MARK: - Private Methods
}
