import Foundation
import Parse
import AlamofireImage

class nestedArray: PFObject, PFSubclassing {
    
    @NSManaged var images: [UIImage]?
    
    
    static func parseClassName() -> String {
        return "nestedArray"
        }
    }

