//
//  DescriptionLblCell.swift
//  MyYouTubeB02
//
//  Created by Marius on 24/08/2018.
//  Copyright © 2018 Marius. All rights reserved.
//

import UIKit
import Kingfisher

class DescriptionLblCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var descriptionLbl: UILabel!
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - Overriden Methods
    
    // MARK: - IBActions
    
    // MARK: - Public Methods
    func configureCell(description: String) {
        descriptionLbl.text = description
    }
    // MARK: - Private Methods
}
