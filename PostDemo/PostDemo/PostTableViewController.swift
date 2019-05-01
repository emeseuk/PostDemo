//
//  PostTableViewController.swift
//  PostDemo
//
//  Created by Emese Toth on 27/04/2019.
//  Copyright © 2019 Emese Toth. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController {
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        downloadImageAssets()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "postCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostCell
        cell.textLabel?.text = posts[indexPath.row].title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPostDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! PostDetailViewController
                destinationController.posts = self.posts
            }
        }
    }
    
    func downloadImageAssets() {
        NetworkManager().download() { postArray in
            self.posts = postArray
            self.tableView.reloadData()
        }
    }
}
