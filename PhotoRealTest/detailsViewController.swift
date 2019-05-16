//
//  detailsViewController.swift
//  PhotoReal
//
//  Created by Anthony Ronca on 5/15/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import UIKit
import Parse

class detailsViewController: UIViewController {
    
    var collageID = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "collage")
        query.includeKeys(["AnchorImage", "A_Index", "B_Index", "C_Index", "D_Index", "E_Index", "F_Index", "G_Index", "H_Index" ])

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
