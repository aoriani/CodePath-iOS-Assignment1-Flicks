//
//  MovieCell.swift
//  Flicks
//
//  Created by Andre Oriani on 2/5/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit
import AFNetworking

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 1, green: 204.0/255, blue: 102.0/255, alpha: 1)
        selectedBackgroundView = backgroundView
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        if let posterUrl = movie.posterUrl {
            posterImageView.fadedSetImageWithUrl(posterUrl)
        }
    }

}
