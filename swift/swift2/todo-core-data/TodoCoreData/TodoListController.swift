//
//  TodoListController.swift
//  TodoCoreData
//
//  Created by Lin David, US-205 on 10/23/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import UIKit
import CoreData

class TodoListController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    
    lazy var fetchResultsController: TodoFetchedResultsController = {
        let controller = TodoFetchedResultsController(managedObjectContext: self.managedObjectContext, withTableView: self.tableView)
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showItem" {
            guard let destinationController = segue.destinationViewController as? DetailViewController, indexPath = tableView.indexPathForSelectedRow else { return }
            
            let item = fetchResultsController.objectAtIndexPath(indexPath) as! Item
            destinationController.item = item
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        return configureCell(cell, atIndexPath: indexPath)
    }
    
    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = self.fetchResultsController.objectAtIndexPath(indexPath) as! Item
        cell.textLabel?.text = item.text
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let item = fetchResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        managedObjectContext.deleteObject(item)
        DataController.sharedInstance.saveContext()
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
}
