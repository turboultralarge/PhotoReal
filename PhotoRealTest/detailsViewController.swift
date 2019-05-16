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
            
            let imageFileA = cluster["A_Index"] as! PFFileObject
            let urlStringA = imageFileA.url!
            let urlA = URL(string: urlStringA)!
            a.af_setImage(withURL: urlA)
            
            let imageFileB = cluster["B_Index"] as! PFFileObject
            let urlStringB = imageFileB.url!
            let urlB = URL(string: urlStringB)!
            b.af_setImage(withURL: urlB)
            
            let imageFileC = cluster["C_Index"] as! PFFileObject
            let urlStringC = imageFileC.url!
            let urlC = URL(string: urlStringC)!
            c.af_setImage(withURL: urlC)
            
            let imageFileD = cluster["D_Index"] as! PFFileObject
            let urlStringD = imageFileD.url!
            let urlD = URL(string: urlStringD)!
            d.af_setImage(withURL: urlD)
 
            let imageFileE = cluster["E_Index"] as! PFFileObject
            let urlStringE = imageFileE.url!
            let urlE = URL(string: urlStringE)!
            e.af_setImage(withURL: urlE)
            
            let imageFileF = cluster["F_Index"] as! PFFileObject
            let urlStringF = imageFileF.url!
            let urlF = URL(string: urlStringF)!
            f.af_setImage(withURL: urlF)
            
            let imageFileG = cluster["G_Index"] as! PFFileObject
            let urlStringG = imageFileG.url!
            let urlG = URL(string: urlStringG)!
            g.af_setImage(withURL: urlG)
            
            let imageFileH = cluster["H_Index"] as! PFFileObject
            let urlStringH = imageFileH.url!
            let urlH = URL(string: urlStringH)!
            h.af_setImage(withURL: urlH)
    
            
        } catch {}
        
        

    }

}
