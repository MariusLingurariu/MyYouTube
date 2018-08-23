//
//  VideosHandler.swift
//  MyYouTubeB02
//
//  Created by Marius on 21/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VideosHandler {
    
    // MARK: - Public Properties
    static let shared = VideosHandler()
    
    var trendingVideos: [VideoModel] = []
    var channelDetails: [ChannelDetails] = []
    
    var channelDetailsId = ""
    
    // MARK: - Private Properties
    private let trendingVideosURL = "https://www.googleapis.com/youtube/v3/videos?part=snippet&chart=mostPopular&regionCode=ro&videoCategoryId=1&key=AIzaSyCSoiisQo6LvVm_wdGTgZK647ag4wR92Us&pageToken="
    private var nextPageToken = ""
    private let channelDetailsUrl = "https://www.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&key=AIzaSyCSoiisQo6LvVm_wdGTgZK647ag4wR92Us&id="
    
    // MARK: - Public Methods
    func downloadTrendingVideos(completed: @escaping DownloadComplete) {
        Alamofire.request("\(trendingVideosURL)\(nextPageToken)").responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let nextPage = dict["nextPageToken"] as? String { self.nextPageToken = nextPage }
                
                if let arrayJson = JSON(dict["items"]).array {
                    for item in arrayJson {
                        let videoModel = VideoModel(json: item)
                        self.trendingVideos.append(videoModel)
                    }
                }
            }
            completed()
        }
    }

    
    func downloadChannelDetails(completed: @escaping DownloadComplete) {
        Alamofire.request("\(channelDetailsUrl)\(channelDetailsId)").responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let arrayJson = JSON(dict["items"]).array {
                    
                    for item in arrayJson {
                        let channelDet = ChannelDetails(json: JSON(arrayJson[0]))
                        self.channelDetails.append(channelDet)
                    }
                }
            }
        }
    }
    
    // MARK: - Private Methods

}
