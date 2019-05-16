//
//  collageObject.swift
//  PhotoReal
//
//  Created by Anthony Ronca on 5/14/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import Foundation
//import UIKit
import ARKit


class collageObject {
    
    var title: String
    var ARAnchor: ARReferenceImage
    var UIAnchor: UIImage
    var a_Image: UIImage
    var b_Image: UIImage
    var c_Image: UIImage
    var d_Image: UIImage
    var e_Image: UIImage
    var f_Image: UIImage
    var g_Image: UIImage
    var h_Image: UIImage
    
    init(title: String = "Collage", ARAnchor: ARReferenceImage, UIAnchor: UIImage, a_Image: UIImage, b_Image: UIImage, c_Image: UIImage, d_Image: UIImage, e_Image: UIImage, f_Image: UIImage, g_Image: UIImage, h_Image: UIImage)
    {
        self.title = title
        self.ARAnchor = ARAnchor
        self.UIAnchor = UIAnchor
        self.a_Image = a_Image
        self.b_Image = b_Image
        self.c_Image = c_Image
        self.d_Image = d_Image
        self.e_Image = e_Image
        self.f_Image = f_Image
        self.g_Image = g_Image
        self.h_Image = h_Image
        
    }
    
}
