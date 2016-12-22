//
//  Item+CoreDataProperties.swift
//  TodoCoreData
//
//  Created by Lin David, US-205 on 10/23/16.
//  Copyright © 2016 Lin David. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var completed: Bool
    @NSManaged var text: String?

}
