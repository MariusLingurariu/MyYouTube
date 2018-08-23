//
//  SecondViewController.swift
//  MyYouTubeB02
//
//  Created by Marius on 21/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import UIKit

class TrendingVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var videoList: UITableView!
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoList.delegate = self
        videoList.dataSource = self
        
        VideosHandler.shared.downloadTrendingVideos {
            self.videoList.reloadData()
            for item in VideosHandler.shared.trendingVideos {
                VideosHandler.shared.channelDetailsId = item.snippet.channelId
                VideosHandler.shared.downloadChannelDetails {
                    self.videoList.reloadData()
                }
            }
        }
    }
    
    // MARK: - IBActions
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods

}

extension TrendingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //on cell click
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VideosHandler.shared.trendingVideos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as? VideoCell{
            let vid = VideosHandler.shared.trendingVideos[indexPath.row]
            let chanelDetails = VideosHandler.shared.channelDetails.count > indexPath.row ?  VideosHandler.shared.channelDetails[indexPath.row] : ChannelDetails()
            cell.cofifigureCell(videoModel: vid, channelDetails: chanelDetails)
            if indexPath.row == VideosHandler.shared.trendingVideos.count - 1 {
                VideosHandler.shared.downloadTrendingVideos {
                    self.videoList.reloadData()
                    for item in VideosHandler.shared.trendingVideos {
                        VideosHandler.shared.channelDetailsId = item.snippet.channelId
                        VideosHandler.shared.downloadChannelDetails {
                            self.videoList.reloadData()
                        }
                    }
                }
            }
            return cell
        }
        return VideoCell()
    }
}

