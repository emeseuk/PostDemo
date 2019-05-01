//
//  Post.swift
//  PostDemo
//
//  Created by Emese Toth on 30/04/2019.
//  Copyright © 2019 Emese Toth. All rights reserved.
//

import Foundation


class Post {
    var title : String
    var id : Int
    var authorName : String
    var authorUsername : String
    var body : String
    var numberOfComments : Int
    
    init(title: String, id: Int, authorName: String, authorUsername: String, body: String, numberOfComments: Int) {
        self.title = title
        self.id = id
        self.authorName = authorName
        self.authorUsername = authorUsername
        self.body = body
        self.numberOfComments = numberOfComments
    }
    
    convenience init(){
        self.init(title: "", id: 0, authorName: "", authorUsername: "", body: "", numberOfComments: 0) 
    }
}
