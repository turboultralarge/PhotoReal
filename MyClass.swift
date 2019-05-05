//
//  MyClass.swift
//  PhotoReal
//
//  Created by Anthony Ronca on 5/5/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import Foundation
import Parse

class MyClass: PFObject { }

extension MyClass: PFSubclassing {
    static func parseClassName() -> String {
        return "MyClass"
    }
}
