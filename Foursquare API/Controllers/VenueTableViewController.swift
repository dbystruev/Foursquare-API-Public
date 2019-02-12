//
//  VenueTableViewController.swift
//  Foursquare API
//
//  Created by Denis Bystruev on 12/02/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class VenueTableViewController: UITableViewController {
    var venue: Venue?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryIconImageView: UIImageView!
    
    func updateUI() {
        guard let venue = venue else { return }
        
        nameLabel.text = venue.name
        descriptionLabel.text = venue.desc
        addressLabel.text = venue.location.address
        categoryNameLabel.text = venue.categories.first?.name
        
        venue.categories.first?.icon.fetch(completion: { image in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                self.categoryIconImageView.image = image
            }
        })
    }
}
