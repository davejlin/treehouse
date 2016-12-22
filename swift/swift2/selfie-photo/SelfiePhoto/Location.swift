//
//  Location.swift
//  SelfiePhoto
//
//  Created by Lin David, US-205 on 11/14/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import Foundation
import CoreData

class Location: NSManagedObject {
    static let entityName = "\(Location.self)"

    class func locationWith(latitude: Double, longitude: Double) -> Location {
        let location = NSEntityDescription.insertNewObjectForEntityForName(Location.entityName, inManagedObjectContext: CoreDataController.sharedInstance.managedObjectContext) as! Location
        location.latitude = latitude
        location.longitude = longitude
        return location
    }
}

extension Location {
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
}