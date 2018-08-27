//
//  VideoDescriptionCell.swift
//  MyYouTubeB02
//
//  Created by Marius on 24/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import UIKit

class VideoDescriptionCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var videoDescriptionLbl: UILabel!
    @IBOutlet weak var viewsNumberLbl: UILabel!
    @IBOutlet weak var likesNumberLbl: UILabel!
    @IBOutlet weak var dislikesNumberLbl: UILabel!
    @IBOutlet weak var showDescriptionButton: UIButton!
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - Overriden Methods
    
    // MARK: - IBActions
    
    // MARK: - Public Methods
    func configureCell(videoDescription: String, viewsNumber: String, likesNumber: String, dislikesNumber: String, showDescription: Bool){
        videoDescriptionLbl.text = videoDescription
        viewsNumberLbl.text = !showDescription ?  viewsNumber != "" ? "\(Int(viewsNumber)!/1000) K" : viewsNumber : viewsNumber 
        likesNumberLbl.text = likesNumber
        dislikesNumberLbl.text = dislikesNumber
        showDescriptionButton.setImage(
            !showDescription ? UIImage(named: "sort-down-24") : UIImage(named: "sort-up-24"),
            for: .normal)
    }
    
    // MARK: - Private Methods
}
