//
//  MovieDetailsViewController.swift
//  Flicks
//
//  Created by Andre Oriani on 2/6/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movie: Movie!

    @IBOutlet weak var posterImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let posterUrl = movie.fullResolutionPosterUrl { posterImageView.setImageWithURL(posterUrl)
        }
    }
}
