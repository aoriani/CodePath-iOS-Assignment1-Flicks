//
//  MovieDataSource.swift
//  Flicks
//
//  Created by Andre Oriani on 2/6/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import UIKit

class MovieDataSource:NSObject, UITableViewDataSource {
    
    private var tableView: UITableView
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
    
    init(forTable tableView:  UITableView) {
        self.tableView = tableView
        super.init()
        
        self.tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getActiveItems().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! MovieCell
        cell.populate(getActiveItems()[indexPath.row])
        return cell
    }
    
    private func update() {
        applyFilter()
        tableView.reloadData()
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