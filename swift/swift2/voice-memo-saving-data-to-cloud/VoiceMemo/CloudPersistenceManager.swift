//
//  CloudPersistenceManager.swift
//  VoiceMemo
//
//  Created by Screencast on 9/3/16.
//  Copyright © 2016 Treehouse Island, Inc. All rights reserved.
//

import Foundation
import CloudKit

enum PersistenceError: MemoErrorType {
    case SaveFailed(description: String)
    case InsufficientInformation
    case InvalidData
    case QueryFailed(description: String, userInfo: [NSObject: AnyObject])
    
    var description: String {
        switch self {
        case .SaveFailed(let description): return "Save Failed: \(description)"
        case .QueryFailed(let description, let userInfo):
            return "Query Failed. Description: \(description), userInfo: \(userInfo.description)"
        default: return String(self)
        }
    }
}

class CloudPersistenceManager {
//    let privateDatabase = CKContainer.defaultContainer().privateCloudDatabase
    let privateDatabase = CKContainer(identifier: "iCloud.com.teamtreehouse.VoiceMemos").privateCloudDatabase
    
    func save(memo: Memo, completion: Result<Memo> -> Void) {
        let record = memo.persistableRecord
        
        privateDatabase.saveRecord(record) { record, error in
            
            guard let record = record else {
                if let error = error {
                    let persistenceError = PersistenceError.SaveFailed(description: error.localizedDescription)
                    completion(.Failure(persistenceError))
                } else {
                    let persistenceError = PersistenceError.InsufficientInformation
                    completion(.Failure(persistenceError))
                }
                
                return
            }
            
            guard let memo = Memo(record: record) else {
                let error = PersistenceError.InvalidData
                completion(.Failure(error))
                return
            }
            
            completion(.Success(memo))
        }
    }
    
    func performQuery(query: CKQuery, completion: Result<[Memo]> -> Void) {
        privateDatabase.performQuery(query, inZoneWithID: nil) { records, error in
            
            guard let records = records else {
                if let error = error {
                    let persistenceError = PersistenceError.QueryFailed(description: error.localizedDescription, userInfo: error.userInfo)
                    completion(.Failure(persistenceError))
                } else {
                    let persistenceError = PersistenceError.InsufficientInformation
                    completion(.Failure(persistenceError))
                }
                return
            }
            
            let memos = records.flatMap { Memo(record: $0) }
            completion(.Success(memos))
        }
    }
    
    func fetch(recordID: CKRecordID, completion: Result<Memo> -> Void) {
        privateDatabase.fetchRecordWithID(recordID) { record, error in
            guard let record = record else {
                if let error = error {
                    let persistenceError = PersistenceError.QueryFailed(description: error.localizedDescription, userInfo: error.userInfo)
                    completion(.Failure(persistenceError))
                } else {
                    let persistenceError = PersistenceError.InsufficientInformation
                    completion(.Failure(persistenceError))
                }
                
                return
            }
            
            guard let memo = Memo(record: record) else {
                let error = PersistenceError.InvalidData
                completion(.Failure(error))
                return
            }
            
            completion(.Success(memo))
        }
    }
    
}
































