//
//  Item.swift
//  TodoCoreData
//
//  Created by Lin David, US-205 on 10/23/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import Foundation
import CoreData


class Item: NSManagedObject {
    static let identifier = "Item"

    static let fetchRequest: NSFetchRequest = {
        let request = NSFetchRequest(entityName: Item.identifier)
        let sortDescriptor = NSSortDescriptor(key: "text", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }()

}
