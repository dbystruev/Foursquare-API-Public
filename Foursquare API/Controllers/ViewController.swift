//
//  ViewController.swift
//  Foursquare API
//
//  Created by Denis Bystruev on 22/01/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import MapKit
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    let url = URL(string: "https://api.foursquare.com/v2/venues/search")!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        loadData()
    }
    
    func loadData() {
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "Please get your key from https://developer.foursquare.com/"),
            URLQueryItem(name: "client_secret", value: "Please get your key from https://developer.foursquare.com/"),
            URLQueryItem(name: "ll", value: "55.751857, 37.666629"),
            URLQueryItem(name: "v", value: "20190205"),
        ]
        
        let requestURL = urlComponents.url!
        
        URLSession.shared.dataTask(with: requestURL) { data, _, _ in
            
            guard let data = data else {
                print(#function, "ERROR: Can't load data from \(requestURL.absoluteString)")
                return
            }
            
            guard let venues = Response(data: data) else {
                print(#function, "ERROR: List of venues is empty")
                return
            }
            
            DispatchQueue.main.async {
                let venues = venues.response.venues
                
                self.navigationItem.title = "Venues loaded: \(venues.count)"
                
                self.mapView.showAnnotations(venues, animated: true)
            }
            
        }.resume()
    }
}

extension ViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if size.height < size.width {
            topStackView.axis = .horizontal
        } else {
            topStackView.axis = .vertical
        }
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        mapView.deselectAnnotation(view.annotation, animated: true)
        
        guard let venue = view.annotation as? Venue else { return }
        
        print(#function, venue)
    }
}
