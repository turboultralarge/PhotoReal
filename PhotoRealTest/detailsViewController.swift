//
//  detailsViewController.swift
//  PhotoReal
//
//  Created by Anthony Ronca on 5/15/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class detailsViewController: UIViewController {
    
    var collageID = String()
    
    // OUTLETS

    
    @IBOutlet var collageTitle: UITextView!
    @IBOutlet var anchor: UIImageView!
    @IBOutlet var a: UIImageView!
    @IBOutlet var b: UIImageView!
    @IBOutlet var c: UIImageView!
    @IBOutlet var d: UIImageView!
    @IBOutlet var e: UIImageView!
    @IBOutlet var f: UIImageView!
    @IBOutlet var g: UIImageView!
    @IBOutlet var h: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(" collage ID : \(collageID)")
        
        let query = PFQuery(className: "collage")
        query.includeKeys(["AnchorImage", "A_Index", "B_Index", "C_Index", "D_Index", "E_Index", "F_Index", "G_Index", "H_Index" ])
        do { let cluster = try query.getObjectWithId(collageID)
            
            let imageFile = cluster["AnchorImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            anchor.af_setImage(withURL: url)
            
            
        } catch {}
        
        

    }

}
