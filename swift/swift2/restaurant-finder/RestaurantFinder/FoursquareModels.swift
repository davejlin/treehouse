//
//  FoursquareModels.swift
//  RestaurantFinder
//
//  Created by Lin David, US-205 on 10/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

extension Coordinate: CustomStringConvertible {
    var description: String {
        return "\(latitude),\(longitude)"
    }
}

struct Location {
    let coordinate: Coordinate?
    let distance: Double?
    let countryCode: String?
    let country: String?
    let state: String?
    let city: String?
    let streetAddress: String?
    let crossStreet: String?
    let postalCode: String?
}

extension Location: JSONDecodable {
    init?(json: JSON) {
        
        if let lat = json["lat"] as? Double, lon = json["lng"] as? Double {
            coordinate = Coordinate(latitude: lat, longitude: lon)
        } else {
            coordinate = nil
        }
        
        distance = json["distance"] as? Double
        countryCode = json["cc"] as? String
        country = json["country"] as? String
        state = json["state"] as? String
        city = json["city"] as? String
        streetAddress = json["address"] as? String
        crossStreet = json["crossStreet"] as? String
        postalCode = json["postalCode"] as? String
    }
}

struct Venue {
    let id: String
    let name: String
    let location: Location?
    let categoryName: String
    let checkins: Int
}

extension Venue: JSONDecodable {
    init?(json: JSON) {
        guard let id = json["id"] as? String, name = json["name"] as? String else {
            return nil
        }
        
        guard let categories = json["categories"] as? [JSON], let category = categories.first, let categoryName = category["shortName"] as? String else {
            return nil
        }
        
        guard let stats = json["stats"] as? JSON, let checkinsCount = stats["checkinsCount"] as? Int else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.categoryName = categoryName
        self.checkins = checkinsCount
        
        if let locationDict = json["location"] as? JSON {
            self.location = Location(json: locationDict)
        } else {
            self.location = nil
        }
    }
}