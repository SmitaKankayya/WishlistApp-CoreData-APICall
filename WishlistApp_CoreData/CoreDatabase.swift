//
//  CoreDatabase.swift
//  WishlistApp_CoreData
//
//  Created by Smita Kankayya on 25/01/24.
//

import Foundation
import CoreData
import UIKit

class DatabaseManager{
    static let shared = DatabaseManager()
    
    private init(){ 
        
    }
    
    func insertDataFromApiToDb(users : User ){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Person", in: manageContext)
        let eachUser = NSManagedObject(entity: (userEntity)!, insertInto: manageContext)
        eachUser.setValue(users.name, forKey: "name")
        eachUser.setValue(users.username, forKey: "username")
        eachUser.setValue(users.email, forKey: "email")
        eachUser.setValue(users.address.city, forKey: "city")
        eachUser.setValue(users.address.geo.lat, forKey: "lat")
        eachUser.setValue(users.address.geo.lng, forKey: "lng")
        do{
            try manageContext.save()
        }
        catch{
            print("data not saved")
        }
    }
}
