
//  LibraryCollectionViewController.swift
//  PhotoReal
//
//  Created by JAVIER VILLA on 4/11/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import UIKit
import Parse

class LibraryCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var LibraryCollection: UICollectionView!
    
    let reuseIdentifier = "cell"
    var clusters = [PFObject] ( )
    var cellImage = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewDidLoad - no crash in this block")
        
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
                }
            }
        }
        

        self.LibraryCollection.reloadData()
        
        print(self.clusters)
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return clusters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LibraryCollectionViewCell
        let cluster = clusters[indexPath.item]
        //let anchorImage = cluster

        cell.anchorView = cluster["anchorImage"] as? UIImageView
        //print(cluster["anchorImage"])
        
        // Configure the cell
        return cell
    }
  }

