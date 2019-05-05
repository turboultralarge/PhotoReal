//
//  LibraryCollectionViewController.swift
//  PhotoReal
//
//  Created by JAVIER VILLA on 4/11/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import UIKit
import Parse

private let reuseIdentifier = "Cell"

class LibraryCollectionViewController: UICollectionViewController {
    
    //  OUTLETS
    @IBOutlet var test: UIImageView!
    
    @IBOutlet var LibraryCollection: UICollectionView!
 
    
    var cluster = [PFObject] ( )
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        LibraryCollection.delegate = self
        LibraryCollection.dataSource = self
        
        let layout = LibraryCollection.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let width = ( view.frame.size.width - layout.minimumInteritemSpacing * 2 ) / 2
        
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        //  Queries the database for collage information
//        let query = PFQuery(className: "collage")
//
//        query.includeKeys(["AnchorImage", "A_Index", "B_Index", "C_Index", "D_Index", "E_Index", "F_Index", "G_Index", "H_Index" ])
//        query.limit = 20
//
////        anchorImage.image = (query["AnchorImage"] as! [PJObject] ?? []
//
//        query.getFirstObjectInBackground { (collage: PFObject?, error: Error?) -> Void in
//                if let error = error {
//                    //The query returned an error
//                    print(error.localizedDescription)
//                } else {
//                    //The object has been retrieved
//                        print("IMAGE OBJECT RECEIVED")
//                    self.test.image = collage!["AnchorImage"] as? UIImage
//                }
        
            
//            if (collage!["AnchorImage"] != nil) {
//                self.test.image = collage!["AnchorImage"] as? UIImage
//            }
            
//        }
        
//        test.image = collage!["AnchorImage"] as? UIImage
       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
