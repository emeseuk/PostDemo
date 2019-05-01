//
//  User.swift
//  PostDemo
//
//  Created by Emese Toth on 30/04/2019.
//  Copyright © 2019 Emese Toth. All rights reserved.
//

import Foundation

struct UserFromJSON : Decodable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
}

struct Address : Decodable{
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo
}

struct Geo : Decodable{
    var lat: String
    var lng: String
}

struct Company : Decodable{
    var name: String
    var catchPhrase: String
    var bs: String
}
