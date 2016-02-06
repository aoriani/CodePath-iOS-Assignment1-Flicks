//
//  DataModels.swift
//  Flicks
//
//  Created by Andre Oriani on 2/5/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import ELCodable

struct Movie: Decodable {
    let posterPath: String?
    let overview: String
    let releaseDate: String
    let genreIds: [UInt]
    let id: UInt
    let originalTitle:String
    let originalLanguage: String
    let title: String
    let backdropPath: String
    let popularity: Decimal
    let voteCount: UInt
    let voteAverage: Decimal
    
    var posterUrl: NSURL? {
        return buildPosterPath("https://image.tmdb.org/t/p/w342")
    }
    
    var lowResolutionPosterUrl: NSURL? {
        return buildPosterPath("https://image.tmdb.org/t/p/w45")
    }
    
    var fullResolutionPosterUrl: NSURL? {
        return buildPosterPath("https://image.tmdb.org/t/p/original")
    }
    
    private func buildPosterPath(baseUrl: String) -> NSURL? {
        if let posterPath = posterPath {
            return NSURL(string: baseUrl + posterPath)
        } else {
            return nil
        }
    }
    
    static func decode(json: JSON?) throws -> Movie {
        return try Movie(
            posterPath: json ==> "poster_path",
            overview: json ==> "overview",
            releaseDate: json ==> "release_date",
            genreIds: json ==> "genre_ids",
            id: json ==> "id",
            originalTitle: json ==> "original_title",
            originalLanguage: json ==> "original_language",
            title: json ==> "title",
            backdropPath: json ==> "backdrop_path",
            popularity: json ==> "popularity",
            voteCount: json ==> "vote_count",
            voteAverage: json ==> "vote_average"
        )
    }
}

struct ResultPage: Decodable {
    let page: UInt
    let results: [Movie]
    let totalPages: UInt
    let totalResults: UInt
    
    static func decode(json: JSON?) throws -> ResultPage {
        return try ResultPage(
            page: json ==> "page",
            results: json ==> "results",
            totalPages: json ==> "total_pages",
            totalResults: json ==> "total_results"
        )
    }
    
}