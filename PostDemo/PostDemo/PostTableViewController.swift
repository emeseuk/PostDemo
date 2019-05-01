//
//  PostTableViewController.swift
//  PostDemo
//
//  Created by Emese Toth on 27/04/2019.
//  Copyright © 2019 Emese Toth. All rights reserved.
//

import UIKit
import CoreData

class PostTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var posts : [PostMO] = []
    var fetchResultController: NSFetchedResultsController<PostMO>!


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        downloadDataFromJson()
        self.fetchPosts()
    }

   // MARK: - Table view data source
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
                destinationController.post = self.posts[indexPath.row]
            }
        }
    }
    
    func fetchPosts(){
        // Fetch data from data store
        let fetchRequest: NSFetchRequest<PostMO> = PostMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                               managedObjectContext: context,
                                                               sectionNameKeyPath: nil,
                                                               cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    posts = fetchedObjects
                }
            } catch {
                print(error)
            }
        }

    }
    
    func downloadDataFromJson() {
        NetworkManager().download() {
            self.fetchPosts()
            self.tableView.reloadData()
        }
    }
}
