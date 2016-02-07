//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Andre Oriani on 2/5/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var topView: UIView!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var errorToast: UIView!
    let movieDbService = MovieDBService()
    var movieDataSource: MovieDataSource!
    var contentLoaderTask: AsyncNetTask?
    var loaderMethod:  (MovieDBService -> (success: (ResultPage) -> Void, failure: () -> Void) -> AsyncNetTask)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        errorToast.hidden = true
        movieTableView.delegate = self
        movieDataSource = MovieDataSource(forTable: movieTableView)
        
        //Initial Load
        let progressDialog = MBProgressHUD.showHUDAddedTo(topView, animated: true)
        progressDialog.labelText = "Loading"
        progressDialog.color = UIColor.darkGrayColor()
        progressDialog.show(true)
        loaderMethod(movieDbService)(success: {
                resultPage in
                    self.movieDataSource.items = resultPage.results
                    progressDialog.hide(true)
            },
            failure: {
                progressDialog.hide(false)
                self.showErrorToast()
        })
        
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.blackColor()
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: "refreshContent:", forControlEvents: UIControlEvents.ValueChanged)
        movieTableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    func refreshContent(refreshControl: UIRefreshControl) {
        if contentLoaderTask == nil {
            loaderMethod(movieDbService)(success: {
                resultPage in
                    self.movieDataSource.items = resultPage.results
                    refreshControl.endRefreshing()
            },
            failure: {
                refreshControl.endRefreshing()
                self.showErrorToast()
            })
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
        let indexPath = movieTableView.indexPathForCell(sender as! MovieCell)
        let movie = movieDataSource.items[indexPath!.row]
        movieDetailsViewController.movie = movie
        movieDetailsViewController.navigationItem.title = movie.title
        movieDetailsViewController.hidesBottomBarWhenPushed = true
    }
    
    func showErrorToast() {
        errorToast.hidden = false
        errorToast.alpha = 0
        UIView.animateWithDuration(0.3,
            delay: 0,
            options: .CurveEaseIn,
            animations: {
                self.errorToast.alpha = 1
            },
            completion: {
            _ in UIView.animateWithDuration(0.3,
                delay: 2,
                options: .CurveEaseOut,
                animations: {
                    self.errorToast.alpha = 0
                },
                completion: {
                    _ in self.errorToast.alpha = 1
                    self.errorToast.hidden = true
            })
        })
    }
}

