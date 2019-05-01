//
//  Post.swift
//  PostDemo
//
//  Created by Emese Toth on 29/04/2019.
//  Copyright © 2019 Emese Toth. All rights reserved.
//

import Foundation

struct PostFromJSON : Decodable {
    var userId : Int
    var id : Int
    var title : String
    var body : String
}
