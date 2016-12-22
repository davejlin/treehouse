//
//  TodoListFetchedResultsController.swift
//  TodoCoreData
//
//  Created by Lin David, US-205 on 10/23/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class TodoFetchedResultsController: NSFetchedResultsController, NSFetchedResultsControllerDelegate {
    private let tableView: UITableView
    
    init(managedObjectContext: NSManagedObjectContext, withTableView tableView: UITableView) {
        self.tableView = tableView
        super.init(fetchRequest: Item.fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.delegate = self
        
        tryFetch()
    }
    
    func tryFetch() {
        do {
            try performFetch()
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
        }
    }
    
    // MARK:  NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
}