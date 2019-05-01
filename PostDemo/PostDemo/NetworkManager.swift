//
//  NetworkManager.swift
//  PostDemo
//
//  Created by Emese Toth on 30/04/2019.
//  Copyright © 2019 Emese Toth. All rights reserved.
//

import Foundation

class NetworkManager {
    
    var posts = [PostFromJSON]()
    var users = [UserFromJSON]()
    var comments = [CommentFromJSON]()

    let jsonAddresses =  ["http://jsonplaceholder.typicode.com/users",
                          "http://jsonplaceholder.typicode.com/comments",
                          "http://jsonplaceholder.typicode.com/posts"]
    
    func download(withCompletion completion: @escaping ([Post]) -> ()) {
        
        let downloadGroup = DispatchGroup()
        
        for jsonUrlString in jsonAddresses {
            downloadGroup.enter()
            guard let url = URL(string: jsonUrlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                
                guard let data = data else { return }
                
                do {
                    if jsonUrlString.hasSuffix("users") {
                        self.users = try JSONDecoder().decode([UserFromJSON].self, from: data)
                        downloadGroup.leave()
                        
                    } else if jsonUrlString.hasSuffix("comments") {
                        self.comments = try JSONDecoder().decode([CommentFromJSON].self, from: data)
                        downloadGroup.leave()
                        
                    } else if jsonUrlString.hasSuffix("posts") {
                        self.posts = try JSONDecoder().decode([PostFromJSON].self, from: data)
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
            completion(self.createPost(self.posts, self.comments, self.users))
        }
    }
    
    func getNumberOfComments(_ comments: [CommentFromJSON]) ->  [Int: Int] {
        var counts: [Int: Int] = [:]
        for comment in comments {
            counts[comment.postId, default: 0] += 1
        }
        return counts
    }
    
    func createPost(_ posts: [PostFromJSON],_ comments: [CommentFromJSON], _ users: [UserFromJSON]) -> [Post]{
        var objs = [Post]()
        var commentCountArray = getNumberOfComments(comments)
        
        for p in posts {
            let obj = Post()
            obj.title = p.title
            obj.id = p.id
            obj.body = p.body
            obj.numberOfComments = commentCountArray[p.id] ?? 0
            obj.authorName = users[p.userId - 1].name
            obj.authorUsername = users[p.userId - 1].username
            objs.append(obj)
        }
        return objs
    }
}
