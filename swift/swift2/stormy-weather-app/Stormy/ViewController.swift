//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 4/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

extension CurrentWeather {
    var temperatureString: String {
        return "\(Int(temperature))º"
    }
    
    var humidityString: String {
        let percentageValue = Int(humidity * 100)
        return "\(percentageValue)%"
    }
    
    var precipitationProbabilityString: String {
        let percentageValue = Int(precipitationProbability * 100)
        return "\(percentageValue)%"
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private static let forecastAPIKey = "89a49f4c339998d20903054b5191925c" // use your darksky.net weather API key here
    private let coordinate = Coordinate(latitude: 42.0429429, longitude: -87.68146)
    private lazy var forecastAPIClient = ForecastAPIClient(APIKey: forecastAPIKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchCurrentWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchCurrentWeather() {
        forecastAPIClient.fetchCurrentWeather(coordinate) { result in
            dispatch_async(dispatch_get_main_queue()) {
                self.toggleRefreshAnimation(false)
            }
            switch result {
            case .Success(let currentWeather):
                dispatch_async(dispatch_get_main_queue()) {
                    self.display(currentWeather)
                }
            case .Failure(let error as NSError):
                dispatch_async(dispatch_get_main_queue()) {
                    self.showAlert("Unable to retrieve forecast", message: error.localizedDescription)
                }
            default: break
            }
        }
    }
    
    func display(weather: CurrentWeather) {
        currentTemperatureLabel.text = weather.temperatureString
        currentPrecipitationLabel.text = weather.precipitationProbabilityString
        currentHumidityLabel.text = weather.humidityString
        currentSummaryLabel.text = weather.summary
        currentWeatherIcon.image = weather.icon
    }
    
    func showAlert(title: String, message: String?, style: UIAlertControllerStyle = .Alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let dismissAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(dismissAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func refreshButtonTapped(sender: AnyObject) {
        fetchCurrentWeather()
        toggleRefreshAnimation(true)
    }
    
    func toggleRefreshAnimation(on: Bool) {
        refreshButton.hidden = on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}










