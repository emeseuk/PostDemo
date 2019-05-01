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

class NetworkManager {
    
    var posts = [PostFromJSON]()
    var users = [UserFromJSON]()
    var comments = [CommentFromJSON]()
    
    var post : PostMO!

    let jsonAddresses =  ["http://jsonplaceholder.typicode.com/users",
                          "http://jsonplaceholder.typicode.com/comments",
                          "http://jsonplaceholder.typicode.com/posts"]
    
    func download(withCompletion completion: @escaping () -> ()) {
        
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
        
        downloadGroup.wait(timeout: DispatchTime.now() + 5)
        
        DispatchQueue.main.async {
            self.createPost(self.posts, self.comments, self.users)
            completion()
        }
    }
    
    func getNumberOfComments(_ comments: [CommentFromJSON]) ->  [Int: Int] {
        var counts: [Int: Int] = [:]
        for comment in comments {
            counts[comment.postId, default: 0] += 1
        }
        return counts
    }
    
    func createPost(_ posts: [PostFromJSON],_ comments: [CommentFromJSON], _ users: [UserFromJSON]){
        
        if UserDefaults.standard.bool(forKey: "hasDownloadedPosts") {
            return
        }
        
        var commentCountArray = getNumberOfComments(comments)
        
        for p in posts {
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                post = PostMO(context: appDelegate.persistentContainer.viewContext)
                post.title = p.title
                post.id = Int32(p.id)
                post.body = p.body
                let comment = commentCountArray[p.id] ?? 0
                post.numberOfComments = Int32(comment)
                post.authorName = users[p.userId - 1].name
                post.authorUsername = users[p.userId - 1].username
                appDelegate.saveContext()
            }
            UserDefaults.standard.set(true, forKey: "hasDownloadedPosts")
        }
        print("Saving data to context ...")
    }
    

}
