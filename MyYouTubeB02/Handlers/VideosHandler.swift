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
    var sugestedVideos: [VideoModel] = []
    var commentList: [CommentModel] = []
    var videoDetails: VideoDetailsModel!
    
    var channelDetailsId = ""
    var videoDetailsId = ""
    var sugestedVideosId = ""
    var commentsVideoId = ""
    var commentsNextPageToken = ""
    var sugestedVideosPageToken = ""
    
    // MARK: - Private Properties
    private let trendingVideosURL = "https://www.googleapis.com/youtube/v3/videos?part=snippet&chart=mostPopular&regionCode=ro&videoCategoryId=1&key=AIzaSyCSoiisQo6LvVm_wdGTgZK647ag4wR92Us&pageToken="
    private var nextPageToken = ""
    private let channelDetailsUrl = "https://www.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id="
    private let videoDetailsUrl = "https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id="
    private let key = "&key=AIzaSyCSoiisQo6LvVm_wdGTgZK647ag4wR92Us"
    private let sugestedVideosUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video"
    private let sugestedVideosPageTokenUrl = "&pageToken="
    private let sugestedVideosIdUrl = "&relatedToVideoId="
    private let commentsUrl = "https://www.googleapis.com/youtube/v3/commentThreads?part=snippet%2Creplies&videoId="
    
    // MARK: - Public Methods
    func downloadComments(completed: @escaping DownloadComplete) {
        Alamofire.request("\(commentsUrl)\(commentsVideoId)\(key)\(sugestedVideosPageTokenUrl)\(commentsNextPageToken)").responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let nextPage = dict["nextPageToken"] as? String { self.commentsNextPageToken = nextPage }
                
                if let arrayJson = JSON(dict["items"]).array {
                    for item in arrayJson {
                        let commentModel = CommentModel(json: item)
                        self.commentList.append(commentModel)
                    }
                }
            }
            completed()
        }
    }
    
    func downloadSugestedVideos(completed: @escaping DownloadComplete) {
        Alamofire.request("\(sugestedVideosUrl)\(key)\(sugestedVideosIdUrl)\(sugestedVideosId)\(sugestedVideosPageTokenUrl)\(sugestedVideosPageToken)").responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let nextPage = dict["nextPageToken"] as? String { self.sugestedVideosPageToken = nextPage }
                
                if let arrayJson = JSON(dict["items"]).array {
                    for item in arrayJson {
                        let videoModel = VideoModel(json: item)
                        self.sugestedVideos.append(videoModel)
                    }
                }
            }
            completed()
        }
    }
    
    func downloadVideoDetails(completed: @escaping DownloadComplete) {
        Alamofire.request("\(videoDetailsUrl)\(videoDetailsId)\(key)").responseJSON { response in
            let result = response.result
            print(result.value)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let arrayJson = JSON(dict["items"]).array {
                    self.videoDetails = VideoDetailsModel(json: arrayJson[0])
                }
            }
            completed()
        }
    }
    
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
            completed()
        }
    }
    
    // MARK: - Private Methods

}
