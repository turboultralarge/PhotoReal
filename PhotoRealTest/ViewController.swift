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
import CoreMedia

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    //Configuration Variables
    private var imageConfiguration: ARImageTrackingConfiguration?
    
    
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
            sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin] //This isn't working here?
            sceneView.session.run(configuration)
        }
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
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
        imageConfiguration?.trackingImages = referenceImages
    }
} //class

    // -----
    
    extension ViewController: ARSCNViewDelegate {
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            DispatchQueue.main.async {} //Hide objects callback
            if let imageAnchor = anchor as? ARImageAnchor {
                handleFoundImage(imageAnchor, node)
            } else if let objectAnchor = anchor as? ARObjectAnchor { //This is for finding objects, which probably we won't need
                //handleFoundObject(ObjectAnchor, node)
            }
        } //renderer()
        
        //Handles a found IMAGE
        private func handleFoundImage(_ imageAnchor: ARImageAnchor, _ node: SCNNode) {
            let name = imageAnchor.referenceImage.name!
            print("Found image: \(name)")
            
            let size = imageAnchor.referenceImage.physicalSize
            if let imageNode = makeImage(size: size) {
                node.addChildNode(imageNode)
                node.opacity = 0.1
                print("bababooey")
            } else {
                print("OH NO")
                let tempShape = SCNBox(width: 0.1, height: 0.0, length: 0.15, chamferRadius: 0)
                let tempNode = SCNNode(geometry: tempShape)
                tempShape.firstMaterial?.diffuse.contents = UIImage(named: "highlight_green.png")
                tempShape.firstMaterial?.lightingModel = .constant
                node.addChildNode(tempNode)
                print("'size' var width: \(size.width) height: \(size.height)")
 
            }
            
        } //handleFoundImage()
        
        
        private func makeImage(size: CGSize) -> SCNNode? {
            guard let imagePath = Bundle.main.url(forResource: "gabe_newell", withExtension: "jpg") else { return nil }
            
            print("Preparing size: width: \(size.width) height: \(size.height)")
            let newImage = SCNPlane(width: size.width, height: size.height) //size    CGSize    (width = 0.10159999877214432, height = 0.1269999984651804)
            newImage.firstMaterial?.diffuse.contents = UIImage(named: "highlight_green.png")
            newImage.firstMaterial?.lightingModel = .constant
            let newImageNode = SCNNode(geometry: newImage)
            newImageNode.eulerAngles.x = -.pi / 2
            
            return newImageNode
            
        }
        
        
        //Handles a found OBJECT via a callback function
        private func handleFoundObject(_ objectAnchor: ARObjectAnchor, _ node: SCNNode) {
            DispatchQueue.main.sync {} //This is where the good things happen (Show objects)
            
        } //handleFoundObject()
    } //extension
    
    
    

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }

