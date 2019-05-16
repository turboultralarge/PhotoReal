
//  LibraryCollectionViewController.swift
//  PhotoReal
//
//  Created by JAVIER VILLA on 4/11/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class LibraryCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var LibraryCollection: UICollectionView!
    
   // let reuseIdentifier = "cell"
    var clusters = [PFObject]()
    var cellImage = [UIImage]()
    var collageID = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewDidLoad - no crash in this block")
        
        LibraryCollection.delegate = self
        LibraryCollection.dataSource = self
        
        let layout = LibraryCollection.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let width = ( view.frame.size.width - layout.minimumInteritemSpacing * 2 ) / 2
        layout.itemSize = CGSize(width: width, height: width * 2 / 2)
        
        self.getData()
        self.LibraryCollection.reloadData()
        
        
        
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return clusters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //self.LibraryCollection.reloadData()
        print("creating cell")
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LibraryCollectionViewCell
        
        //print("THIS ACTUALLY DUD SOMETHING")
        print(indexPath.item)
    
        let cluster = clusters[indexPath.item]
        let imageFile = cluster["AnchorImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        collageID = (cluster.objectId)!
        
        cell.anchorView.af_setImage(withURL: url)
     
        return cell
    }
    
    func getData(){
        let query = PFQuery(className: "collage")
        
        query.includeKeys(["AnchorImage", "objectID" ])
        query.limit = 20
        
        do {clusters = try query.findObjects()}
        catch {}
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //detailsViewController.collageID = collageID.text
        let destinationVC = segue.destination as! detailsViewController
        destinationVC.collageID = collageID
    }
  }

