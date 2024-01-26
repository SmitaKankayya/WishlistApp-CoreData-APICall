//
//  UsersDM.swift
//  WishlistApp_CoreData
//
//  Created by Smita Kankayya on 25/01/24.
//

import Foundation

struct User : Decodable{
    let name: String
    let username: String
    let email: String
    let address: Address
}

struct Address : Decodable {
    let city: String
    let geo: Geo
}

struct Geo : Decodable{
    let lat: String
    let lng: String
}

