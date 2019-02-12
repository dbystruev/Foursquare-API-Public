//
//  Venue.swift
//  Foursquare API
//
//  Created by Denis Bystruev on 29/01/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import MapKit

struct Response: Codable {
    let response: Venues
    
    init?(data: Data?) {
        guard let data = data else { return nil }
        
        let decoder = JSONDecoder()
        
        guard let response = try? decoder.decode(Response.self, from: data) else { return nil }
        
        self.response = response.response
    }
}

struct Venues: Codable {
    let venues: [Venue]
}

class Venue: NSObject, Codable {
    let name: String
    let location: Location
    let desc: String?
    let categories: [Category]
    
    enum CodingKeys: String, CodingKey {
        case name
        case location
        case desc = "description"
        case categories
    }
}

struct Location: Codable {
    let address: String?
    let lat: Double
    let lng: Double
}

struct Category: Codable {
    let id: String
    let name: String
    let icon: Icon
}

struct Icon: Codable {
    let prefix: String
    let suffix: String
    
    func fetch(completion: (UIImage?) -> Void) {
        // TODO: fetch the picture
    }
}

extension Venue: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
    }
    
    var title: String? {
        return name
    }
}
