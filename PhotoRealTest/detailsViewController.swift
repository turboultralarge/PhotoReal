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
    var cluster = PFObject()
    
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
        
        let query = PFQuery(className: "collage")
        query.includeKeys(["AnchorImage", "A_Index", "B_Index", "C_Index", "D_Index", "E_Index", "F_Index", "G_Index", "H_Index", "Title" ])

        do { cluster = try query.getObjectWithId(collageID)}
        catch {}
        
               DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
        //collageTitle.text = cluster.value(forKey:"Title") as? String
        let imageFile = self?.cluster["AnchorImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
                self?.anchor.af_setImage(withURL: url)
        }

    }

}
