//
//  PostDetailViewController.swift
//  PostDemo
//
//  Created by Emese Toth on 29/04/2019.
//  Copyright © 2019 Emese Toth. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts = [Post]()
    
    @IBOutlet var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cellIdentifier = "userCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserCell
            cell.name.text = posts[indexPath.row].authorName
            cell.userName.text = posts[indexPath.row].authorUsername
            return cell
        case 1:
            let cellIdentifier = "commentCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommentCell
            cell.postDescription.text = posts[indexPath.row].body
            cell.commentNumber.text = posts[indexPath.row].numberOfComments.description
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
}
