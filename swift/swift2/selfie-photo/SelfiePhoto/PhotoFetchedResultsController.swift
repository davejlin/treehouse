//
//  PhotoFetchedResultsController.swift
//  SelfiePhoto
//
//  Created by Lin David, US-205 on 11/14/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import UIKit
import CoreData

class PhotoFetchedResultsController: NSFetchedResultsController, NSFetchedResultsControllerDelegate {
    private let collectionView: UICollectionView
    
    init(fetchRequest: NSFetchRequest, managedObjectContext: NSManagedObjectContext, collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.delegate = self
        executeFetch()
    }
    
    func executeFetch() {
        do {
            try performFetch()
        } catch let error as NSError {
            print ("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func performFetch(withPredicate predicate: NSPredicate?) {
        NSFetchedResultsController.deleteCacheWithName(nil)
        fetchRequest.predicate = predicate
        executeFetch()
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        collectionView.reloadData()
    }
}
