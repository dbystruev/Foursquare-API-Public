//
//  ViewController.swift
//  Foursquare API
//
//  Created by Denis Bystruev on 22/01/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let url = URL(string: "https://api.foursquare.com/v2/venues/search")!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "Replace with your Foursquare Cliend ID"),
            URLQueryItem(name: "client_secret", value: "Replace with your Foursquare Client Secret"),
            URLQueryItem(name: "ll", value: "55.751857, 37.666629"),
            URLQueryItem(name: "v", value: "20190129"),
        ]
        
        let requestURL = urlComponents.url!
        
        print(#function, requestURL.absoluteString)
        
        URLSession.shared.dataTask(with: requestURL) { data, _, _ in
            
            guard let data = data else {
                print(#function, "ERROR: Can't load data from \(requestURL.absoluteString)")
                return
            }
            
            print(#function, data)
            
            let venues = Response(data: data)
            
            print(#function, venues ?? "nil")
            
        }.resume()
    }


}

