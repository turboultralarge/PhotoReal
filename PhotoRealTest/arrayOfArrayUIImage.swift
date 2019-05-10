
import Foundation
import Parse
import AlamofireImage



class arrayOfArrayUIImage: PFObject, PFSubclassing {
    
     @NSManaged var imageArray: [UIImage]?
    
    static func parseClassName() -> String {
        return "arrayOfArrayUIImage"
}

}

