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
    
    
//    OUTLETS
    
    
    
//    ACTIONS

    @IBOutlet var sceneView: ARSCNView!
    
    //Configuration Variables
    private var imageConfiguration: ARImageTrackingConfiguration?
    var emptyImageSet = Set<ARReferenceImage>()
    var referenceImageSet = Set<ARReferenceImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information --------DEBUG
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/empty.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        let query = PFQuery(className: "collage")
        query.getFirstObjectInBackground { (object, error) -> Void in
            
            if error == nil {
                if let passedImage = object {
                    
                   // let image = UIImage(named: )
                    

                    // we have an image object
                    
                    // get the image data
                    
                    //set the image data to a key of the PFObject
                    
                    // save the object to parse
                    
                    
                }
            }
        }
        
        setupImageDetection()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Debug Options
        //sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin] //This stopped working
        
        // Create a session configuration
        //let configuration = ARImageTrackingConfiguration()

        // Run the view's session
        
        if let configuration = imageConfiguration {
            print("Maximum number of tracked images before: \(configuration.maximumNumberOfTrackedImages)")
            sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin] //This isn't working here?
            sceneView.session.run(configuration)
            configuration.maximumNumberOfTrackedImages = 10 //Seems to max out at 4 on a 6S. Still only 1 tracked at a time
            print("Maximum number of tracked images after: \(configuration.maximumNumberOfTrackedImages)")
        }
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
    }
    
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
        imageConfiguration?.trackingImages = emptyImageSet //Change to referenceImages if you want hardcoded images back
    }
    
    func addReferenceImage() {
        //let retrievedImage = UIImage(contentsOfFile: getImageURL(imgName: "Test", type: ".jpg"))
        let retrievedImage = passedImage
        
        //Prepares the image to go into a new ARReferenceImage object
        guard let cgImage = retrievedImage?.cgImage else { return }
        let width = CGFloat(cgImage.width)
        //guard let refSize = 0.0762 else { return }
        
        //Creates a new ARReferenceImage object from the image
        let newRefImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.0762)
        
        //Temporary name for testing
        newRefImage.name = "TestRef"
        
        referenceImageSet.insert(newRefImage)
        imageConfiguration?.trackingImages = referenceImageSet
        
    } //END addReferenceImage
    
} //class

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
                
                if let collageNode = makeCollageImage(size: size, name: name, index: 0) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, index: 1) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, index: 2) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, index: 3) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, index: 4) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, index: 5) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, index: 6) {
                    imageNode.addChildNode(collageNode)
                    imageNode.opacity = 1
                }
                if let collageNode = makeCollageImage(size: size, name: name, index: 7) {
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
        
        private func makeCollageImage(size: CGSize, name: String, index: Int) -> SCNNode? {
            
            //Set the box size to the length
            var boxSize = size.width
            //If the height is longer, set it to that
            if (size.height > size.width) {
                boxSize = size.height
            }
            
            //print("Preparing size: width: \(size.width) height: \(size.height)")
            let newImage = SCNPlane(width: boxSize, height: boxSize)
            let tempImage = UIImage(named: name + "_" + String(index))
            if (tempImage == nil) {
                return nil
            }
            newImage.firstMaterial?.diffuse.contents = UIImage(named: name + "_" + String(index))
            print("Adding Collage Image: \(name + "_" + String(index))")
            newImage.firstMaterial?.lightingModel = .constant
            let newImageNode = SCNNode(geometry: newImage)
            newImageNode.eulerAngles.x = -.pi / 2
            
            let spacing = 0.01
            
            //Based on the index, find the relative offset position
            switch index {
            case 0:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x -= Float(boxSize) + Float(spacing)
                newImageNode.position.y += Float(boxSize) + Float(spacing)
                newImageNode.position.z = 0.0
            case 1:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x = 0.0
                newImageNode.position.y += Float(boxSize) + Float(spacing)
                newImageNode.position.z = 0.0
            case 2:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x += Float(boxSize) + Float(spacing)
                newImageNode.position.y += Float(boxSize) + Float(spacing)
                newImageNode.position.z = 0.0
            case 3:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x += Float(boxSize) + Float(spacing)
                newImageNode.position.y = 0.0
                newImageNode.position.z = 0.0
            case 4:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x += Float(boxSize) + Float(spacing)
                newImageNode.position.y -= Float(boxSize) + Float(spacing)
                newImageNode.position.z = 0.0
            case 5:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x = 0.0
                newImageNode.position.y -= Float(boxSize) + Float(spacing)
                newImageNode.position.z = 0.0
            case 6:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x -= Float(boxSize) + Float(spacing)
                newImageNode.position.y -= Float(boxSize) + Float(spacing)
                newImageNode.position.z = 0.0
            case 7:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x -= Float(boxSize) + Float(spacing)
                newImageNode.position.y = 0.0
                newImageNode.position.z = 0.0
            default:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x = 0.0
                newImageNode.position.y = 0.0
                newImageNode.position.z = 0.0
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


