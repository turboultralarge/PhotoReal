//
//  imageCollection.swift
//  PhotoReal
//
//  Created by Anthony Ronca on 5/3/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import Foundation
import Parse
import AlamofireImage

class imageCollection: PFObject, PFSubclassing {
    
    @NSManaged var images: [PFFileObject]?
    
    
    static func parseClassName() -> String {
        return "imageCollection"
    }
    
    class func imagesToPFObject(arrayOfImages: [UIImage]?) -> [PFFileObject]{
        
        var arrayOfPFileObjects = [PFFileObject]()
        
        if let arrayOfImages = arrayOfImages{
            for index in 0..<arrayOfImages.count {
                arrayOfPFileObjects.append(getPFFileFromImage(image: arrayOfImages[index], imageName: "image\(index).png")!)
            }
        }
        return arrayOfPFileObjects
    }
    
    
    class func getPFFileFromImage(image: UIImage?, imageName: String) -> PFFileObject? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = image.pngData() {
                return PFFileObject(name: imageName, data: imageData)
            }
        }
        return nil
    }
    
    class func PFObjectsToImages(files: [PFFileObject]?) -> [UIImage]{
        var images = [UIImage]()
        if let files = files{
            for file in files{
                file.getDataInBackground { (data, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else{
                        images.append(UIImage(data: data!)!)
                    }
                }
            }
        }
        return images
    }
    /*
     
     let query = imageCollection.query()
     query?.includeKey("images")
     query?.getFirstObjectInBackground(block: { (object, error) in
     if let error = error{
     print(error.localizedDescription)
     }else{
     var imageColl = imageCollection()
     imageColl = object as! imageCollection
     print(object)
     for index in 0..<imageColl.images!.count{
     let urlString = imageColl.images![index].url!
     let url = URL(string: urlString)!
     self.uiimageviews[index].af_setImage(withURL: url)
     print("we got here 🥴")
     }
     print("we got here 🦄")
     }
     })
     
     print("we got here 👍")
     
     */
    
    
    func uploadData(withCompletion completion: PFBooleanResultBlock?) {
        let collection = imageCollection()
        collection.images = self.images!
        collection.saveInBackground(block: completion)
    }
    
    
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



