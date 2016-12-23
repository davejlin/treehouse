//
//  Memo.swift
//  VoiceMemo
//
//  Created by Screencast on 9/1/16.
//  Copyright © 2016 Treehouse Island, Inc. All rights reserved.
//

import Foundation
import CloudKit

struct Memo {
    static let entityName = "\(Memo.self)"
    
    let id: CKRecordID?
    let title: String
    let fileURLString: String
}

extension Memo {
    var fileURL: NSURL {
        return NSURL(fileURLWithPath: fileURLString)
    }
}

extension Memo {
    var persistableRecord: CKRecord {
        let record = CKRecord(recordType: Memo.entityName)
        record.setValue(title, forKey: "title")
        
        let asset = CKAsset(fileURL: fileURL)
        record.setValue(asset, forKey: "recording")
        
        return record
    }
}

extension Memo {
    init?(record: CKRecord) {
        guard let title = record.valueForKey("title") as? String,
            let asset = record.valueForKey("recording") as? CKAsset else {
                return nil
        }
        
        self.id = record.recordID
        self.title = title
        self.fileURLString = asset.fileURL.absoluteString
    }
}

extension Memo {
    var track: NSData? {
        return NSData(contentsOfURL: fileURL)
    }
}



























