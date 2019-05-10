
//  LibraryCollectionViewController.swift
//  PhotoReal
//
//  Created by JAVIER VILLA on 4/11/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

private let reuseIdentifier = "cell"

class LibraryCollectionViewController: UICollectionViewController {
    
    //  OUTLETS
    //@IBOutlet var test: UIImageView!
    
    @IBOutlet var LibraryCollection: UICollectionView!
    
    
    var clusters = [PFObject] ( )
    var cellImage = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LibraryCollection.delegate = self
        LibraryCollection.dataSource = self
        
        let layout = LibraryCollection.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let width = ( view.frame.size.width - layout.minimumInteritemSpacing * 2 ) / 2
        
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        
        let query = PFQuery(className: "collage")
        
        query.includeKeys(["AnchorImage"])
        query.limit = 20
        
        query.findObjectsInBackground{(objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                       // For each object in the class object, append it to myArray(clusters)
                        self.clusters.append(object)
                    }
                   // self.getData()
                }
            }
        }
        
    }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.LibraryCollection!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            
            if let error = error {
                
                print(error.localizedDescription)
                
            } else if let data = data {
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                self.CollectionView.reloadData()
                
                print(self.movies)
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
        
        //self.CollectionView.reloadData()
        
        //print(self.movies)
        
        // Do any additional setup after loading the view.
//    func getData(){
//            // Get Anchor
//            if let userPicture = objects.value(forKey: "AnchorImage") as? PFFileObject {
//                userPicture.getDataInBackground(block: {
//                    (imageData: Data!, error: Error!) -> Void in
//                    if (error == nil) {
//                        let image = UIImage(data:imageData)
//                        self.anchors.append(image!)
//                   })
//
//
//                        // Successfully Query Parse
//
//                        self.parseImage = UIImage(data:imageData!) // single Anchor image for testing purposes
//                        print("Parse Image Received")
//
//                    }
//                }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LibraryCollectionViewCell
    
        let cluster = clusters[indexPath.item]
        let anchorImage = cluster
        
        cell.
        
        
        
        // Configure the cell
        return cell
    }
  }

