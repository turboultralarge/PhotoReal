//
//  ViewController.swift
//  PhotoRealTest
//
//  Created by Travis Abendshien on 4/3/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
//import CoreMedia //For videos later
import Parse

class ARViewController: UIViewController {
    
    //  Receives UIImage StaticTestImage from AddCollageVC
    
    var passedImage: UIImage?
    var parseImage: UIImage?
    var clusters = [imageCollection]()
//    var collages = [PFObject]()
    var collages = [UIImage]()
    var imageObjects = [PFObject]()

    
    
//    OUTLETS

    
    
//    ACTIONS

    @IBOutlet var sceneView: ARSCNView!
    
    //Configuration Variables
    private var imageConfiguration: ARImageTrackingConfiguration?
    var emptyImageSet = Set<ARReferenceImage>()  //  Empty set of image resources used for testing purposes
    var referenceImageSet = Set<ARReferenceImage>()  //  holding set of Reference images
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did Load")
        
        // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information --------DEBUG
        sceneView.showsStatistics = true
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/empty.scn")!
        // Set the scene to the view
        sceneView.scene = scene
        
        // Parse Query for image data
        //  Queries the database for collage information
        let query = PFQuery(className:"cluster")
        
        query.includeKeys(["imageArray"])
        query.limit = 20
        
//        let x = imageCollection()
//        collages = x.image!
        
        
        
//        query.value(forKey:"imageArray")
//        query.findObjectsInBackground()
//        
//        
//        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
//            if let error = error {
//                // The request failed
//                print(error.localizedDescription)
//            } else if let objects = objects as? [imageCollection], let firstCluster = objects.first {
//                self.clusters.append(firstCluster)
//                print("succesfully cast")
//                //...
//            } else {
//                print("no dice! - No clusters received.")
//            }
//        }
////        do { imageObjects = try query.findObjects()
//        }
//        catch { print("error - \(LocalizedError.self)") }
//
//        for object in imageObjects{
//            var imgData = object as! PFFileObject
//        }
        
        
        
        //Get the data from the PFQuery class
//        var count = 0  //  increment counter
        
//        if let userPicture = object.valueForKey("Image")! as! PFFile {
//            userPicture.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
//                let image = UIImage(data: imageData!)
//                if image != nil {
//                    self.imageArray.append(image!)
//                }
//            })
//        }
        
//        if let imgData = query.value(forKey: "imageArray") as? PFFileObject {
//            imgData.getDataInBackground()
//                var images = imgData as [UIImage
//                self.clusters.append(imgData) as? imageCollection
//            }
        
        
//        query.findObjectsInBackground(){(objects,error) ->
//            Void in
//
//            if objects != nil && error == nil{
//                for object in objects!{
//                        do { try object.fetch() }  //  Make sure to use updated data
//                        catch{ print("error fetching") }
//                    //let imgData = object["imageArray"] as [UIImage]
//                    //self.collages.append(object["imageArray"] as! imageCollection)
//                    var imgData = object as! PFFileObject
//                    self.clusters.append(object as! imageCollection)
//                        //self.clusters[count] = (collage["imageArray"]) as! imageCollection
////                        count += 1
//                    }
//                }
//            }
        
        
        print("Amount of clusters: \(clusters.count)")
 

}

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("ViewWillAppear")
    }   // end ViewWillAppearn
    
    
    @IBAction func DoneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    private func setupImageDetection() {
        imageConfiguration = ARImageTrackingConfiguration()
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Images", bundle: nil) else {
            fatalError("Can't find the AR Images folder!")
        }
        addReferenceImage()
        
       // imageConfiguration?.trackingImages = emptyImageSet //Change to referenceImages if you want hardcoded images back
        //print("Loaded empty configuration!")
    }
    
    func addReferenceImage() {
        //let retrievedImage = UIImage(contentsOfFile: getImageURL(imgName: "Test", type: ".jpg"))
        
        let retrievedImage = parseImage
        
        //let passedFromParseUIImage = parseImage
        
        //Prepares the image to go into a new ARReferenceImage object  Test case no longer needed
       guard let cgImage = retrievedImage?.cgImage else { return }
        //guard let cgImageFromParse = passedFromParseUIImage?.cgImage else { return }
        let width = CGFloat(cgImage.width)
        //guard let refSize = 0.0762 else { return }
        
        //Creates a new ARReferenceImage object from the image
        let newRefImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.0762) //3 inches in meters
        
        //let newRefImageFromParse = ARReferenceImage(cgImageFromParse, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.0762)
        
        //Temporary name for testing
        newRefImage.name = "TestRef"
        
        //newRefImageFromParse.name = "ImageFromParse"
        
        //Check number of images in set before new image is added
        print("Number of images in set Before Insert: \(referenceImageSet.count)")
        referenceImageSet.insert(newRefImage)
        
        print("Number of images in set After Insert: \(referenceImageSet.count)")
        //referenceImageSet.insert(newRefImageFromParse)
        
        imageConfiguration?.trackingImages = referenceImageSet
        print("Loaded new configuration!")
        
        print("Number of images in set After New Config: \(referenceImageSet.count)")

        
    } //END addReferenceImage
    
} //END class

    // -----
    
    extension ARViewController: ARSCNViewDelegate {
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            DispatchQueue.main.async {} //Hide things callback
            if let imageAnchor = anchor as? ARImageAnchor {
                handleFoundImage(imageAnchor, node)
                /*
            } else if let objectAnchor = anchor as? ARObjectAnchor { //This is for finding objects, which probably we won't need
                //handleFoundObject(ObjectAnchor, node)
                */
            }
        } //renderer()
}
        
        //Handles a found IMAGE
        private func handleFoundImage(_ imageAnchor: ARImageAnchor, _ node: SCNNode) {
            let name = imageAnchor.referenceImage.name!
            print("Found image: \(name)")
            
            let size = imageAnchor.referenceImage.physicalSize
            if let imageNode = makeImage(size: size) { //NOTE: This implemtation is really sloppy right now
                node.addChildNode(imageNode)
                node.opacity = 1
                //print("Image matches size")
                
                if let collageNode = makeCollageImage(size: size, name: name, collageIndex: 0) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, collageIndex: 1) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, collageIndex: 2) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, collageIndex: 3) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, collageIndex: 4) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, collageIndex: 5) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, collageIndex: 6) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, collageIndex: 7) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                
            } else {
                
                print("Image does NOT match size")
                let tempShape = SCNBox(width: size.width, height: 0.0, length: size.height, chamferRadius: 0)
                let tempNode = SCNNode(geometry: tempShape)
                tempShape.firstMaterial?.diffuse.contents = UIImage(named: "highlight_cyan.png")
                tempShape.firstMaterial?.lightingModel = .constant
                node.addChildNode(tempNode)
                print("'size' var width: \(size.width) height: \(size.height)")
                
            }
        } //handleFoundImage()

        
        private func makeImage(size: CGSize) -> SCNNode? {
            //guard let imagePath = Bundle.main.url(forResource: "gabe_newell", withExtension: "jpg") else { return nil }
            
            //print("Preparing size: width: \(size.width) height: \(size.height)")
            let newImage = SCNPlane(width: size.width, height: size.height) //size    CGSize    (width = 0.10159999877214432, height = 0.1269999984651804)
            newImage.firstMaterial?.diffuse.contents = UIImage(named: "highlight_green.png")
            newImage.firstMaterial?.lightingModel = .constant
            let newImageNode = SCNNode(geometry: newImage)
            newImageNode.eulerAngles.x = -.pi / 2
            
            return newImageNode
            
        }
        
        private func makeCollageImage(size: CGSize, name: String, collageIndex: Int) -> SCNNode? {
            
            //Set the box size to the length
            var boxSize = size.width
            //If the height is longer, set it to that
            if (size.height > size.width) {
                boxSize = size.height
            }
            
            //print("Preparing size: width: \(size.width) height: \(size.height)")
            let newImage = SCNPlane(width: boxSize, height: boxSize)
            let tempImage = UIImage(named: name + "_" + String(collageIndex))
            if (tempImage == nil) {
                return nil
            }
            
            //Going to need a switch statement to determine which letter index array to look in for the UIImage
            
            //name paramater will be changed to array index location
            //index location will be specifying collageIndex
            
            //newImage.firstMaterial?.diffuse.contents = //Gets image associated with anchor image  - NEW LINE
            //newImage.firstMaterial?.diffuse.contents = UIImage(named: name + "_" + String(index)) - OLD LINE
            print("Adding Collage Image: \(name + "_" + String(collageIndex))")
            newImage.firstMaterial?.lightingModel = .constant
            let newImageNode = SCNNode(geometry: newImage)
            newImageNode.eulerAngles.x = -.pi / 2
            
            let spacing = 0.01
            
            //Based on the index, find the relative offset position
            switch collageIndex {
            case 0:
                //newImageNode.rotation.w = 0.0
                newImageNode.position.x -= Float(boxSize) + Float(spacing)
                newImageNode.position.y += Float(boxSize) + Float(spacing)
                //newImageNode.position.z = 0.0
            case 1:
                //newImageNode.rotation.w = 0.0
                //newImageNode.position.x = 0.0
                newImageNode.position.y += Float(boxSize) + Float(spacing)
                //newImageNode.position.z = 0.0
            case 2:
                //newImageNode.rotation.w = 0.0
                newImageNode.position.x += Float(boxSize) + Float(spacing)
                newImageNode.position.y += Float(boxSize) + Float(spacing)
                //newImageNode.position.z = 0.0
            case 3:
                //newImageNode.rotation.w = 0.0
                newImageNode.position.x += Float(boxSize) + Float(spacing)
                //newImageNode.position.y = 0.0
                //newImageNode.position.z = 0.0
            case 4:
                //newImageNode.rotation.w = 0.0
                newImageNode.position.x += Float(boxSize) + Float(spacing)
                newImageNode.position.y -= Float(boxSize) + Float(spacing)
                //newImageNode.position.z = 0.0
            case 5:
                //newImageNode.rotation.w = 0.0
                //newImageNode.position.x = 0.0
                newImageNode.position.y -= Float(boxSize) + Float(spacing)
                //newImageNode.position.z = 0.0
            case 6:
                //newImageNode.rotation.w = 0.0
                newImageNode.position.x -= Float(boxSize) + Float(spacing)
                newImageNode.position.y -= Float(boxSize) + Float(spacing)
                //newImageNode.position.z = 0.0
            case 7:
                //newImageNode.rotation.w = 0.0
                newImageNode.position.x -= Float(boxSize) + Float(spacing)
                //newImageNode.position.y = 0.0
                //newImageNode.position.z = 0.0
            default:
                newImageNode.rotation.w = 0.0
                //newImageNode.position.x = 0.0
                //newImageNode.position.y = 0.0
                //newImageNode.position.z = 0.0
            }
            
            return newImageNode
            
        } //END makeCollageImage()



   
    func setUI() {
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }

//Takes in the anchor image name, searches the "anchors" array and returns the index it was found at
func getAnchorImageIndex() {
    
}


class collages {
    var anchorImage = UIImage()
    var a_Image = UIImage()
    var b_Image = UIImage()
    var c_Image = UIImage()
    var d_Image = UIImage()
    var e_Image = UIImage()
    var f_Image = UIImage()
    var g_Image = UIImage()
    var h_Image = UIImage()
    
    init(){
    
    }
}
