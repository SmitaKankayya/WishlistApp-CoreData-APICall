//
//  DetailsViewController.swift
//  WishlistApp_CoreData
//
//  Created by Smita Kankayya on 25/01/24.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    var usersDetailsContainer : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    func  bindData(){
        
        self.nameLabel.text = usersDetailsContainer?.name
        self.userNameLabel.text = usersDetailsContainer?.username
        self.emailLabel.text = usersDetailsContainer?.email
        self.cityLabel.text = usersDetailsContainer?.address.city
        self.latitudeLabel.text = usersDetailsContainer?.address.geo.lat
        self.longitudeLabel.text = usersDetailsContainer?.address.geo.lng
    }
    
    @IBAction func AddWishlist(_ sender: Any) {
        DatabaseManager.shared.insertDataFromApiToDb(users: usersDetailsContainer!)
        
    }
}






