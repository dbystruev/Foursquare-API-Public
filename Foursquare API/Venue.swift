//
//  Venue.swift
//  Foursquare API
//
//  Created by Denis Bystruev on 29/01/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

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

struct Venue: Codable {
    let name: String
    let location: Location
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}
