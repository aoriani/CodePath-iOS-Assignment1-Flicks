//
//  MovieDataSource.swift
//  Flicks
//
//  Created by Andre Oriani on 2/6/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import UIKit

class MovieDataSource:NSObject, UITableViewDataSource, UICollectionViewDataSource {
    
    private var tableView: UITableView
    private var gridView: UICollectionView
    
    var items: [Movie] = [] {
        didSet {
            update()
        }
    }
    
    var filter: String  = "" {
        didSet {
            update()
        }
    }
    
    private var filteredView: [Movie] = []
    
    init(forTable tableView:  UITableView, andGrid gridView: UICollectionView) {
        self.tableView = tableView
        self.gridView = gridView
        super.init()
        
        self.tableView.dataSource = self
        self.gridView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getActiveItems().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! MovieCell
        cell.populate(getActiveItems()[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getActiveItems().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.gridView.dequeueReusableCellWithReuseIdentifier("movieGridCell", forIndexPath: indexPath) as! MovieGridCell
        cell.populate(getActiveItems()[indexPath.row])
        return cell
    }
    
    private func update() {
        applyFilter()
        tableView.reloadData()
        gridView.reloadData()
    }
    
    private func applyFilter() {
        let criteria = filter.trim()
        filteredView.removeAll()
        
        if (!criteria.isEmpty) {
            for movie in items {
                if movie.title.contains(criteria) {
                    filteredView.append(movie)
                }
            }
        }
    }
    
    private func getActiveItems() -> [Movie] {
        return filter.trim().isEmpty ? items : filteredView
    }
    
}

extension String {
    func contains(aString: String) -> Bool {
        return self.lowercaseString.rangeOfString(aString.lowercaseString) != nil
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}