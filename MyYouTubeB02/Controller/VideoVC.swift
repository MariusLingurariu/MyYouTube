//
//  VideoVC.swift
//  MyYouTubeB02
//
//  Created by Marius on 22/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import UIKit
import WebKit

class VideoVC: UIViewController, WKUIDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var video: UIWebView!
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    public var videoId: String = ""
    
    // MARK: - Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        print(videoId)
        let urlString = "<html><body style='margin:0px;padding:0px;'><script type='text/' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){ a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='100%\' height='100%\' src='http://www.youtube.com/embed/\(videoId)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'></body></html>"
        
        print(urlString)
        video.allowsInlineMediaPlayback = true
        video.mediaPlaybackRequiresUserAction = false
        video.loadHTMLString(urlString, baseURL: nil)
        video.scrollView.isScrollEnabled = false
        video.scrollView.bounces = false
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods

    

}
