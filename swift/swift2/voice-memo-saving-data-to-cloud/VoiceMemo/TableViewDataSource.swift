//
//  TableViewDataSource.swift
//  VoiceMemo
//
//  Created by Screencast on 9/5/16.
//  Copyright © 2016 Treehouse Island, Inc. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    private var results: [Memo]
    private let tableView: UITableView
    
    init(tableView: UITableView, results: [Memo]) {
        self.tableView = tableView
        self.results = results
        super.init()
        
        self.tableView.dataSource = self
    }
    
    func objectAtIndexPath(indexPath: NSIndexPath) -> Memo {
        return results[indexPath.row]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MemoCell.reuseIdentifier, forIndexPath: indexPath)
        
        let memo = results[indexPath.row]
        cell.textLabel?.text = memo.title
        
        return cell
    }
}

extension TableViewDataSource: DataProviderDelegate {
    
    func processUpdates(updates: [DataProviderUpdate<Memo>]) {
        tableView.beginUpdates()
        
        for (index, update) in updates.enumerate() {
            switch update {
            case .Insert(let memo):
                results.insert(memo, atIndex: index)
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
        
        tableView.endUpdates()
    }
    
    func providerFailedWithError(error: MemoErrorType) {
        print("Provider failed with error: \(error.description)")
    }
}




























