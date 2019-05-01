//
//  Comment.swift
//  PostDemo
//
//  Created by Emese Toth on 30/04/2019.
//  Copyright © 2019 Emese Toth. All rights reserved.
//

import Foundation

struct CommentFromJSON : Decodable, Hashable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(postId)
    }
}

