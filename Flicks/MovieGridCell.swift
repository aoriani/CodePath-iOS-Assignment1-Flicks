//
//  MovieGridCell.swift
//  Flicks
//
//  Created by Andre Oriani on 2/7/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit

class MovieGridCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    func populate(movie: Movie) {
        if let posterUrl = movie.posterUrl {
            posterImageView.fadedSetImageWithUrl(posterUrl)
        }
    }
}
