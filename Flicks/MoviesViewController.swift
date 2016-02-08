//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Andre Oriani on 2/5/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var topView: UIView!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var gridView: UICollectionView!
    @IBOutlet weak var errorToast: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var gridTableToggle: UIBarButtonItem!
    
    enum Mode { case List, Grid }
    
    let gridIcon = UIImage(named: "grid")!
    let listIcon = UIImage(named: "list")!
    
    let movieDbService = MovieDBService()
    var movieDataSource: MovieDataSource!
    var contentLoaderTask: AsyncNetTask?
    var mode: Mode = .List
    var loaderMethod:  (MovieDBService -> (success: (ResultPage) -> Void, failure: () -> Void) -> AsyncNetTask)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        errorToast.hidden = true
        movieTableView.delegate = self
        searchBar.delegate = self
        movieDataSource = MovieDataSource(forTable: movieTableView, andGrid: gridView)
        if #available(iOS 9.0, *) {
            (UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self])).textColor = UIColor.whiteColor()
        }
        searchBar.tintColor = UIColor(red: 1, green: 204.0/255, blue: 102.0/255, alpha: 1)

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
        
       updateVisibility()
    }
    
    func updateVisibility() {
        movieTableView.hidden = (mode == .Grid)
        gridView.hidden = (mode == .List)
        gridTableToggle.image = (mode == .List) ? gridIcon : listIcon
    }
    
    @IBAction func toggleMode(sender: AnyObject) {
        
        mode = (mode == .List) ? .Grid : .List
        updateVisibility()
    }
    
    func setupRefreshControl() {
        let refreshControlList = UIRefreshControl()
        refreshControlList.backgroundColor = UIColor.blackColor()
        refreshControlList.tintColor = UIColor.whiteColor()
        refreshControlList.addTarget(self, action: "refreshContent:", forControlEvents: UIControlEvents.ValueChanged)
        movieTableView.insertSubview(refreshControlList, atIndex: 0)
        
        let refreshControlGrid = UIRefreshControl()
        refreshControlGrid.backgroundColor = UIColor.blackColor()
        refreshControlGrid.tintColor = UIColor.whiteColor()
        refreshControlGrid.addTarget(self, action: "refreshContent:", forControlEvents: UIControlEvents.ValueChanged)
        gridView.insertSubview(refreshControlGrid, atIndex: 0)

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
        let indexPath: NSIndexPath?
        if sender is MovieCell{
            indexPath = movieTableView.indexPathForCell(sender as! MovieCell)
        } else {
            indexPath = gridView.indexPathForCell(sender as! MovieGridCell)
        }
        let movie = movieDataSource.items[indexPath!.row]
        movieDetailsViewController.movie = movie
        movieDetailsViewController.navigationItem.title = movie.title
        movieDetailsViewController.hidesBottomBarWhenPushed = true
        
        searchBar.resignFirstResponder()
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
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        movieDataSource.filter = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        movieDataSource.filter = searchText
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
}

