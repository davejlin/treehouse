//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Pasan Premaratne on 4/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let humidity: Double
    let precipitationProbability: Double
    let summary: String
    let icon: UIImage
}

extension CurrentWeather: JSONDecodable {
    init?(json: JSON) {
        guard let temperature = json["temperature"] as? Double,
        humidity = json["humidity"] as? Double,
        precipitationProbability = json["precipProbability"] as? Double,
        summary = json["summary"] as? String,
        iconString = json["icon"] as? String else {
                return nil }
    
        let icon = WeatherIcon(value: iconString).image
    
        self.temperature = temperature
        self.humidity = humidity
        self.precipitationProbability = precipitationProbability
        self.summary = summary
        self.icon = icon
    }
}
