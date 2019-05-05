//
//  imageCollection.swift
//  PhotoReal
//
//  Created by Anthony Ronca on 5/3/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import Foundation
import Parse

class imageCollection: PFObject, PFSubclassing {

    
    
//    @NSManaged var images: [UIImage]
    @NSManaged var identifier: String?
    @NSManaged var image: [PFFileObject]?

    
  static func parseClassName() -> String {
        return "imageCollection"
    }
    
    func uploadData() {}

    
}

extension imageCollection {
    
     func fetchImage(identifier: String) -> [PFObject]{
        
        print("fetching images..")
        var arrayObjects = [PFObject]()
        
        let query = PFQuery(className:"clusters")
//        query?.cachePolicy = .cacheThenNetwork
//        query.whereKey("imageArray", equalTo: identifier)
        
        query.findObjectsInBackground { ( objects, error ) in
            if objects != nil{
                arrayObjects = objects!
                print(arrayObjects)
            }
        }
        
        return arrayObjects
    }
        
//        query?.getObjectInBackground(withId: "imageArray", block: { (objects, error) in
//            if error != nil{
//                print("error")
//            } else {
//
//                let imageObjects = objects
//
//                    let img = object["imageArray"] as PFFileObject
//
//            }
//        })
        
        
        
//        query!.getObjectInBackground(withId: "imageArray") { (object, error) in
//            if error != nil {
//                print("error - \(LocalizedError.self)")
//            } else if let object = object as? imageCollection, var image = object.images {
//
//
//            }
//        }
//
//
//        query?.findObjectsInBackground()
  //      print("attempting fetch")
        
//        do { let imgArray = try query?.findObjects()//
            //let img = UIImage(cgImage: imgArray as! CGImage)
 //           print("something happened")
  //          image?.append(imgArray)
            
 //       }//
 //       catch { print ("fetch error - \(LocalizedError.self)")}
        
//        return image!
        
//        return image
        
//
//        query!.getFirstObjectInBackground {(object, error) in
//            if let error = error {
//                completion?(error: error, image: nil)
//                print("error - \(LocalizedError.self)")
//            } else if let object = object as? imageCollection {
//                let image = object.image
//                image.
//        }
//
//
//            image.getDataInBackground {(data, error) in
//                if let error = error { completion?(error: error, image: nil) }
//                else if let data = data, let image = UIImage(data: data) {
//                    print("Passed images to UIImage class")
//                    completion?(error: nil, image: image)
//
//                }
//    }
//}
//    }
    
    
}  //  end

//extension MyClass: PFSubclassing {
//    static func parseClassName() -> String {
//        return "imageCollection"
//    }
//}



