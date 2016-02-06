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
    var items:[Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(forTable tableView:  UITableView) {
        self.tableView = tableView
        super.init()
        
        self.tableView.dataSource = self
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! MovieCell
        cell.populate(items[indexPath.row])
        return cell
    }
}