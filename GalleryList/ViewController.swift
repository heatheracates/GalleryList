//
//  ViewController.swift
//  GalleryList
//
//  Created by Heather Cates on 11/25/17.
//  Copyright © 2017 Heather Cates. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var galleryItems : [GalleryItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       do{
            galleryItems = try context.fetch(GalleryItem.fetchRequest())
                print(galleryItems)
            tableView.reloadData()
        
       }
       catch {
            print("error in fetching gallery items")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let cellItem = galleryItems[indexPath.row]
        cell.textLabel?.text = cellItem.photoText
        cell.imageView?.image = UIImage(data: cellItem.photo as! Data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellItem = galleryItems[indexPath.row]
        performSegue(withIdentifier: "gallerySegue", sender: cellItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! AddPictureViewController
        nextVC.galleryItem = sender as? GalleryItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

