//
//  SortableDataSource.swift
//  SelfiePhoto
//
//  Created by Lin David, US-205 on 11/15/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol CustomTitleConvertible {
    var title: String { get }
}

extension Tag: CustomTitleConvertible {}

class SortableDataSource<SortType: CustomTitleConvertible where SortType: NSManagedObject>: NSObject, UITableViewDataSource {
 
    private let fetchedResultsController: NSFetchedResultsController
    
    var results: [SortType] {
        return fetchedResultsController.fetchedObjects as! [SortType]
    }
    
    init(fetchedRequest: NSFetchRequest, managedObjectContext moc: NSManagedObjectContext) {
            self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        executeFetch()
    }
    
    func executeFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("executeFetch error \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return fetchedResultsController.fetchedObjects?.count ?? 0
        default: return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "sortableItemCell")
        cell.selectionStyle = .None
        
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            cell.textLabel?.text = "All \(SortType.self)s"
            cell.accessoryType = .Checkmark
        case (1,_):
            guard let sortItem = fetchedResultsController.fetchedObjects?[indexPath.row] as? SortType else {
                break
            }
            
            cell.textLabel?.text = sortItem.title
        default: break
        }
        
        return cell
    }
}