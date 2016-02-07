//
//  MovieDetailsViewController.swift
//  Flicks
//
//  Created by Andre Oriani on 2/6/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit
import ELCodable

class MovieDetailsViewController: UIViewController {
    
    static let ratingFormatter = NSNumberFormatter()
    static let dateFormatter = NSDateFormatter()
    var movie: Movie!

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let posterUrl = movie.fullResolutionPosterUrl {
            posterImageView.setImageWithURL(posterUrl)
        }
        titleLabel.text = movie.title
        ratingLabel.text = formatRating(movie.voteAverage)
        releaseDateLabel.text = formatReleaseDate(movie.releaseDate)
        overViewLabel.text = movie.overview
        overViewLabel.sizeToFit()
        adjustInfoViewSize()
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: infoView.frame.origin.y + infoView.frame.height + 20)
        
    }
    
    private func formatRating(decimal: Decimal) -> String {
        MovieDetailsViewController.ratingFormatter.numberStyle = .DecimalStyle
        MovieDetailsViewController.ratingFormatter.minimumFractionDigits = 1
        MovieDetailsViewController.ratingFormatter.maximumFractionDigits = 1
        return MovieDetailsViewController.ratingFormatter.stringFromNumber(decimal.value)!
    }
    
    private func formatReleaseDate(dateString: String) -> String {
        MovieDetailsViewController.dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = MovieDetailsViewController.dateFormatter.dateFromString(dateString) {
            MovieDetailsViewController.dateFormatter.dateFormat = "MMM d, YYYY"
            return MovieDetailsViewController.dateFormatter.stringFromDate(date)
        } else {
            return "Not Available"
        }
    }
    
    private func adjustInfoViewSize() {
        let height = overViewLabel.frame.origin.y + overViewLabel.frame.height + 20
        infoView.frame.size.height = height
    }
}
