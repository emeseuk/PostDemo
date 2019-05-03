//
//  NetworkManager.swift
//  PostDemo
//
//  Created by Emese Toth on 30/04/2019.
//  Copyright © 2019 Emese Toth. All rights reserved.
//

import UIKit
import Foundation
import CoreData


struct Result  {
    var posts : [PostFromJSON]
    var users : [UserFromJSON]
    var comments : [CommentFromJSON]
}

class NetworkManager {
    
    var result = Result(posts: [PostFromJSON](), users:  [UserFromJSON](), comments: [CommentFromJSON]())
    
    let jsonAddresses =  ["http://jsonplaceholder.typicode.com/users",
                          "http://jsonplaceholder.typicode.com/comments",
                          "http://jsonplaceholder.typicode.com/posts"]
    
    func download(withCompletion completion: @escaping (Result) -> ()) {
        
        let downloadGroup = DispatchGroup()
        
        for jsonUrlString in jsonAddresses {
            downloadGroup.enter()
            guard let url = URL(string: jsonUrlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                
                guard let data = data else { return }
                
                do {
                    if jsonUrlString.hasSuffix("users") {
                        self.result.users = try JSONDecoder().decode([UserFromJSON].self, from: data)
                        downloadGroup.leave()
                        
                    } else if jsonUrlString.hasSuffix("comments") {
                        self.result.comments = try JSONDecoder().decode([CommentFromJSON].self, from: data)
                        downloadGroup.leave()
                        
                    } else if jsonUrlString.hasSuffix("posts") {
                        self.result.posts = try JSONDecoder().decode([PostFromJSON].self, from: data)
                        downloadGroup.leave()
                    }
                    
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                    downloadGroup.leave()
                }
                }.resume()
        }
        
        downloadGroup.wait()
        
        DispatchQueue.main.async {
            completion(self.result)
        }
    }

}
