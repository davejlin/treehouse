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



























