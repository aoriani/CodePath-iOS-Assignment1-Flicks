//
//  Service.swift
//  Flicks
//
//  Created by Andre Oriani on 2/5/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import ELCodable

typealias AsyncNetTask = NSURLSessionDataTask

class WebService {
    private let session = NSURLSession(
        configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
        delegate:nil,
        delegateQueue:NSOperationQueue.mainQueue()
    )
    
    private func performRequest<ResponseType: Decodable>(request:NSURLRequest,
        success: (ResponseType) -> Void = {_ in },
        failure: () -> Void = {}) -> AsyncNetTask {
            let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
                completionHandler: { (data, response, error) in
                    guard let response = response as? NSHTTPURLResponse else {failure(); return}
                    if (error == nil) && (200..<300 ~= response.statusCode) {
                        guard let data = data else {failure(); return}
                        do {
                            let json = JSON(data: data)
                            let model = try ResponseType.decode(json)
                            success(model)
                        } catch {
                            failure()
                        }
                        
                    } else {
                        failure()
                    }
                    
            })
            task.resume()
            return task
    }
}

class MovieDBService: WebService {
    private static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    private static let baseUrl = "https://api.themoviedb.org/3/movie"
    private static let nowPlayingUrl = "\(baseUrl)/now_playing?api_key=\(apiKey)"
    private static let topRatedUrl = "\(baseUrl)/now_playing?api_key=\(apiKey)"
    
    func retrieveNowPlaying(success success: (ResultPage) -> Void = {_ in }, failure: () -> Void = {}) -> AsyncNetTask {
        let request = NSURLRequest(URL: NSURL(string: MovieDBService.nowPlayingUrl)!)
        return performRequest(request, success: success, failure: failure)
    }
    
    func retrieveTopRated(success success: (ResultPage) -> Void = {_ in }, failure: () -> Void = {}) -> AsyncNetTask {
        let request = NSURLRequest(URL: NSURL(string: MovieDBService.topRatedUrl)!)
        return performRequest(request, success: success, failure: failure)
    }
}
