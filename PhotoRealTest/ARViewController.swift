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
    var clusters = [PFObject]()
    var Collages = [collages]()
    
    
    //  Arrays holding columns from Parse
    var anchors = [UIImage]()
    var a_index = [UIImage]()
    var b_index = [UIImage]()
    var c_index = [UIImage]()
    var d_index = [UIImage]()
    var e_index = [UIImage]()
    var f_index = [UIImage]()
    var g_index = [UIImage]()
    var h_index = [UIImage]()
    
    
    
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
        let query = PFQuery(className: "collage")
        
        query.includeKeys(["AnchorImage", "A_Index", "B_Index", "C_Index", "D_Index", "E_Index", "F_Index", "G_Index", "H_Index" ])
        query.limit = 20
        
        //Get the data from the PFQuery class
        
        var i = 0
        
        // Working on saving the data to an Array of Objects (Clusters)
        //  This is the ideal way to do it, but I cannot find a way to unpack the cluster into UIImages
        query.findObjectsInBackground{(objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        //For each object in the class object, append it to myArray(clusters)
                        self.clusters.append(object)
                        i += 1
 
                            
                            //self.anchors[count] = objects["AnchorImage"]  as! UIImage
                            // self.anchors.append((objects["AnchorImage"]  as? UIImage)!)
                            //Could not cast value of type 'PFFileObject' (0x10f7a9500) to 'UIImage' (0x11bc0e598).
                                //count+=1

                            
//                        print("number of Objects dissassembled \(i)")
                        }
                    
                    for objects in self.clusters{
                        
                        if let userPicture = objects.value(forKey: "AnchorImage") as? PFFileObject {
                            userPicture.getDataInBackground(block: {
                                (imageData: Data!, error: Error!) -> Void in
                                if (error == nil) {
                                    let image = UIImage(data:imageData)
                                    self.anchors.append(image!)
                                    if let a_Image = objects.value(forKey:"A_Index") as? PFFileObject {
                                        a_Image.getDataInBackground(block: {
                                            (imageData: Data!, error: Error!) -> Void in
                                            if (error == nil) {
                                                let image = UIImage(data:imageData)
                                                self.a_index.append(image!)
                                                print("a_index accepted")
                                                print("Number of A_Index loaded after: \(self.a_index.count)" )
                                            }
                                        })
                                    }
                                    
                                    // Successfully Query Parse
                                    
                                    self.parseImage = UIImage(data:imageData!) // single Anchor image for testing purposes
                                    print("Parse Images Received")
                                    
                                    // Must be in the same block or image isn't loaded first
                                    self.setupImageDetection()
                                    
                                    if let configuration = self.imageConfiguration {
                                        //print("Maximum number of tracked images before: \(configuration.maximumNumberOfTrackedImages)")
                                        self.sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin] //This isn't working here?
                                        self.sceneView.session.run(configuration)
                                        configuration.maximumNumberOfTrackedImages = 10 //Seems to max out at 4 on a 6S. Still only 1 tracked at a time
                                       //print("Maximum number of tracked images after: \(configuration.maximumNumberOfTrackedImages)")
                                    }
                                    self.sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
                                    
                                            print("Number of Anchors loaded: \(self.anchors.count)" )
                                            print("Number of A_Index loaded: \(self.a_index.count)" )
                                            print(" number of objects from parse in Array: \(i)")
                                }
                            })
                        }
                    }
                }
            }
         }
//
//        print("Number of Anchors loaded: \(self.anchors.count)" )
//        print("Number of A_Index loaded: \(self.a_index.count)" )
//        print(" number of objects from parse in Array: \(i)")
//
//        //else  {
//                //print("\(String(describing: error))")
//            //}
//
//
//        setupImageDetection()
//
//        if let configuration = imageConfiguration {
//            print("Maximum number of tracked images before: \(configuration.maximumNumberOfTrackedImages)")
//            sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin] //This isn't working here?
//            sceneView.session.run(configuration)
//            configuration.maximumNumberOfTrackedImages = 10 //Seems to max out at 4 on a 6S. Still only 1 tracked at a time
//            print("Maximum number of tracked images after: \(configuration.maximumNumberOfTrackedImages)")
//        }
//        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
//
//
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ViewWillAppear")

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
            let sizeBig = CGSize(width: size.width * 1.25, height: size.height * 1.25)
            if let imageNode = makeImage(size: sizeBig) { //NOTE: This implemtation is really sloppy right now
                node.addChildNode(imageNode)
                node.opacity = 1
                //print("Image matches size")
                
                //Adds any applicable collage images
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
                
                //Adds title text
                let text = SCNText(string: "Title", extrusionDepth: 0.0)
                text.font = UIFont.systemFont(ofSize: 1.0)
                text.flatness = 0.005
                text.firstMaterial?.diffuse.contents = UIColor.white
                let textNode = SCNNode(geometry: text)
                let fontScale = Float(0.04)
                textNode.scale = SCNVector3(fontScale, fontScale, fontScale)
                textNode.position.y += Float(fontScale) + Float(0.05)
                let (_, max) = textNode.boundingBox
                textNode.position.x -= Float(max.x)
                
                imageNode.addChildNode(textNode)
                
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
            newImage.firstMaterial?.diffuse.contents = UIImage(named: "highlight_purple.png")
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
