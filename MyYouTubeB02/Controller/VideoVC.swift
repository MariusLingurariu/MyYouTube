//
//  VideoVC.swift
//  MyYouTubeB02
//
//  Created by Marius on 22/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import UIKit
import WebKit

class VideoVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var video: UIWebView!
    @IBOutlet weak var videoList: UITableView!
    
    @IBOutlet var repliesSection: UIView!
    @IBOutlet weak var repliesTableView: UITableView!
    
    @IBOutlet weak var videoDetails: UIView!
    
    // MARK: - Public Properties
    public var videoId: String = ""
    
    // MARK: - Private Properties
    private var videoDescriptionString: String = ""
    private var videoDet: VideoDetailsModel!
    private var viewsNumberShort: String = ""
    private var desc: String = ""
    private var showDescription = false
    private var replies: [CommentSnippetModel] = []
    private var commIndex: Int = 0
    
    // MARK: - Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        videoList.delegate = self
        videoList.dataSource = self
        
        repliesTableView.delegate = self
        repliesTableView.dataSource = self
        
        VideosHandler.shared.sugestedVideos = []
        VideosHandler.shared.commentList = []
        loadVideo(videoId: videoId)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? VideoVC {
            if let videoId = sender as? String {
                destination.videoId = videoId
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func closeRepliesSection(_ sender: Any) {
        hideRepliesSection()
    }
    
    // MARK: - Public Methods
    func loadVideo(videoId: String) {
        let urlString = "<html><body style='margin:0px;padding:0px;'><script type='text/' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){ a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='100%\' height='100%\' src='http://www.youtube.com/embed/\(videoId)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'></body></html>"
        
        video.allowsInlineMediaPlayback = true
        video.mediaPlaybackRequiresUserAction = false
        video.loadHTMLString(urlString, baseURL: nil)
        video.scrollView.isScrollEnabled = false
        video.scrollView.bounces = false
        
        //load sugested videos
        VideosHandler.shared.sugestedVideosId = videoId
        VideosHandler.shared.downloadSugestedVideos {
            VideosHandler.shared.downloadSugestedVideos {
                VideosHandler.shared.downloadSugestedVideos {
                    self.videoList.reloadData()
                }
            }
        }
        
        VideosHandler.shared.videoDetailsId = videoId
        VideosHandler.shared.downloadVideoDetails {
            self.videoList.reloadData()
        }
        
        loadComments()
    }
    
    // MARK: - Private Methods
    private func reinitializeView() {
        VideosHandler.shared.sugestedVideos = []
        VideosHandler.shared.commentList = []
        loadVideo(videoId: self.videoId)
    }
    
    private func hideRepliesSection(){
        UIView.animate(withDuration: 0.5) {
            self.repliesSection.frame.origin.y = self.videoDetails.bounds.maxY
        }
        videoDetails.willRemoveSubview(repliesSection)
    }
    
    private func showRepliesSection(){
        videoDetails.addSubview(repliesSection)
        repliesSection.frame = CGRect(origin: CGPoint(x: 0, y: videoDetails.bounds.maxY), size: videoDetails.bounds.size)
        repliesTableView.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.repliesSection.frame.origin.y = 0
        }
    }
    
    private func loadComments(){
        VideosHandler.shared.commentsVideoId = self.videoId
        VideosHandler.shared.downloadComments {
            self.videoList.reloadData()
        }
    }
}

extension VideoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //on cell click
        if tableView == self.videoList {
            switch indexPath[0]{
            case 0:
                showDescription = !showDescription
                self.videoList.reloadData()
            default:
                print(indexPath.section)
            }
            if indexPath.section == 2 {
                self.videoId = VideosHandler.shared.sugestedVideos[indexPath.row].videoId
                reinitializeView()
            }
            if indexPath.section == 3 {
                if VideosHandler.shared.commentList[indexPath.row].totalReplyCount > 0 {
                    commIndex = indexPath.row
                    showRepliesSection()
                }
            }
        }
        if tableView == self.repliesTableView {
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.videoList {
            switch section {
            case 0:
                return 1
            case 1:
                return showDescription ? 1 : 0
            case 2:
                return VideosHandler.shared.sugestedVideos.count
            default:
                return VideosHandler.shared.commentList.count
            }
        }
        if tableView == self.repliesTableView {
            switch section {
            case 0:
                return 1
            default:
                return VideosHandler.shared.commentList[commIndex].replies.replies.count
            }
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.videoList {
            return 4
        }
        if tableView == self.repliesTableView {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.videoList {
            switch indexPath.section {
            case 0:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "videoDescriptionCell") as? VideoDescriptionCell {
                    let videoDet = VideosHandler.shared.videoDetails != nil ? VideosHandler.shared.videoDetails! : VideoDetailsModel()
                    cell.configureCell(videoDescription: videoDet.snippet.title,
                                       viewsNumber: videoDet.viewCount,
                                       likesNumber: videoDet.likeCount,
                                       dislikesNumber: videoDet.dislikeCount,
                                       showDescription: self.showDescription)
                    self.desc = videoDet.snippet.description
                    return cell
                }
            case 1:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionLblCell") as? DescriptionLblCell {
                    cell.configureCell(description: desc)
                    return cell
                }
            case 2:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "sugestedVideoCell") as? SugestedVideoCell {
                    let sugestedVideos = VideosHandler.shared.sugestedVideos.count > indexPath.row ? VideosHandler.shared.sugestedVideos[indexPath.row] : VideoModel()
                    cell.configureCell(videoModel: sugestedVideos)
                    return cell
                }
            default:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as? CommentCell {
                    if VideosHandler.shared.commentList.count - 2 <= indexPath.row{
                        loadComments()
                    } else {
                        cell.configureCell(commentModel: VideosHandler.shared.commentList[indexPath.row])
                    }
                    return cell
                }
            }
            return SugestedVideoCell()
        }
        if tableView == self.repliesTableView {
            switch indexPath.section {
            case 0:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ReplayHeadCell") as? ReplayHeadCell {
                    let headCell = VideosHandler.shared.commentList[commIndex].commentSnippet != nil ?
                        VideosHandler.shared.commentList[commIndex] : CommentModel()
                    cell.configureCell(commentModel: headCell)
                    return cell
                }
            default:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ReplayViewCell") as? ReplayViewCell {
                    let replayCell = VideosHandler.shared.commentList[commIndex].replies.replies[indexPath.row] != nil ?
                        VideosHandler.shared.commentList[commIndex].replies.replies[indexPath.row] : CommentSnippetModel()
                    cell.configureCell(commentModel: replayCell)
                    return cell
                }
            }
        }
         return SugestedVideoCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
