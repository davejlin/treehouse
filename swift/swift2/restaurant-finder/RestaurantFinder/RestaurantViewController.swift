//
//  RestaurantViewController
//  RestaurantFinder
//
//  Created by Pasan Premaratne on 5/4/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import MapKit

class RestaurantViewController: UITableViewController, MKMapViewDelegate, UISearchResultsUpdating {
    let foursquareClient = FoursquareClient(clientID: "DKRCXAINL2DXBG2DVYCJHQQKA5TDF32NKEYEWLGEFVHEIKBY", clientSecret: "XRCQHNVQWIFNGU3I3FNS2H5FNLW2RJWRUOC01KDADNULOBMU")
    let manager = LocationManager()
    var coordinate: Coordinate?
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var stackView: UIStackView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var venues: [Venue] = [] {
        didSet {
            tableView.reloadData()
            addMapAnnotations()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Search bar configuration
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        stackView.addSubview(searchController.searchBar)
        
        manager.getPermission()
        manager.onLocationFix = {
            [weak self] coordinate in
            self?.coordinate = coordinate
            self?.fetchData()
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                controller.venue = venues[indexPath.row]
                
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath) as! RestaurantCell
        let venue = venues[indexPath.row]
        cell.RestaurantTitleLabel.text = venue.name
        cell.RestaurantCheckinLabel.text = String(venue.checkins)
        cell.RestaurantCategoryLabel.text = venue.categoryName
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    @IBAction func refreshTableView(sender: AnyObject) {
        fetchData()
        self.refreshControl?.endRefreshing()
    }

    func fetchData() {
        guard let coordinate = self.coordinate else { return }
        foursquareClient.fetchRestaurantsFor(coordinate) {
            result in
            switch result {
            case .Success(let venues):
                self.venues = venues
            case .Failure(let error):
                print (error)
            }
        }
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        var region = MKCoordinateRegion()
        region.center = mapView.userLocation.coordinate
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        
        mapView.setRegion(region, animated: true)
    }
    
    func addMapAnnotations() {
        removeMapAnnotation()
        if venues.count > 0 {
            let annotations: [MKPointAnnotation] = venues.map {
                venue in
                let point = MKPointAnnotation()
                
                if let coordinate = venue.location?.coordinate {
                    point.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
                    point.title = venue.name
                }
                
                return point
            }
            
            mapView.addAnnotations(annotations)
        }
    }
    
    func removeMapAnnotation() {
        if mapView.annotations.count != 0 {
            for annotation in mapView.annotations {
                mapView.removeAnnotation(annotation)
            }
        }
    }
    
    // MARK: UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let coordinate = coordinate {
            foursquareClient.fetchRestaurantsFor(coordinate, category: .Food(nil), query: searchController.searchBar.text) {
                result in
                switch result {
                case .Success(let venues):
                    self.venues = venues
                case .Failure(let error):
                    print (error)
                }
            }
        }
    }
}

