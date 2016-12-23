//
//  DataProvider.swift
//  VoiceMemo
//
//  Created by Screencast on 9/4/16.
//  Copyright © 2016 Treehouse Island, Inc. All rights reserved.
//

import Foundation
import CloudKit

protocol DataProviderDelegate: class {
    func processUpdates(updates: [DataProviderUpdate<Memo>])
    func providerFailedWithError(error: MemoErrorType)
}

enum DataProviderUpdate<T> {
    case Insert(T)
}

class DataProvider {
    
    let manager = CloudPersistenceManager()
    var updates = [DataProviderUpdate<Memo>]()
    
    private weak var delegate: DataProviderDelegate?
    
    init(delegate: DataProviderDelegate?) {
        self.delegate = delegate
    }
    
    func performQuery(type type: QueryType) {
        manager.performQuery(type.query) { result in
            self.processResult(result)
        }
    }
    
    func fetch(recordID id: CKRecordID) {
        manager.fetch(id) { result in
            self.processResult(result)
        }
    }
    
    func save(memo: Memo) {
        manager.save(memo) { result in
            self.processResult(result)
        }
    }
    
    private func processResult(result: Result<[Memo]>) {
        dispatch_async(dispatch_get_main_queue()) {
            switch result {
            case .Success(let memos):
                self.updates = memos.map { DataProviderUpdate.Insert($0) }
                self.delegate?.processUpdates(self.updates)
            case .Failure(let error):
                self.delegate?.providerFailedWithError(error)
            }
        }
    }
    
    private func processResult(result: Result<Memo>) {
        dispatch_async(dispatch_get_main_queue()) {
            switch result {
            case .Success(let memo):
                self.updates = [DataProviderUpdate.Insert(memo)]
                self.delegate?.processUpdates(self.updates)
            case .Failure(let error):
                self.delegate?.providerFailedWithError(error)
            }
        }
    }
    
}



























