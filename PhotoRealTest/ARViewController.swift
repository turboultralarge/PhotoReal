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

    var passedImage: UIImage?
    var parseImage: UIImage?
    var clusters = [PFObject]()
    var globalImageCount = 0
    var collageObjects = [collageObject]()
    
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
    
    /*
    //Temporary variables the hold data from Parse, later consolidated into the collageObjects array
    var tempAnchorUI = UIImage()
    var tempAnchorAR
    var tempIndexA = UIImage()
    var tempIndexB = UIImage()
    var tempIndexC = UIImage()
    var tempIndexD = UIImage()
    var tempIndexE = UIImage()
    var tempIndexF = UIImage()
    var tempIndexG = UIImage()
    var tempIndexH = UIImage()
 */
    

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
        //sceneView.showsStatistics = true
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/empty.scn")!
        // Set the scene to the view
        sceneView.scene = scene
        // Parse Query for image data
        //  Queries the database for collage information
        let query = PFQuery(className: "collage")
        query.includeKeys(["AnchorImage", "A_Index", "B_Index", "C_Index", "D_Index", "E_Index", "F_Index", "G_Index", "H_Index" ])
        query.limit = 20
  
        query.findObjectsInBackground{(objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        //For each object in the class object, append it to myArray(clusters)
                        self.clusters.append(object)
                        }
                    self.getData()
                }
            }
         }
        
        // 1
        let delayInSeconds = 2.0
        
        // 2  waits for query to finish before running code
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [weak self] in
            self!.setupImageDetection()
            
            if let configuration = self?.imageConfiguration {
                
                //Creates the collageObjects from the data pulled from parse
                self?.createCollageObjects()
                
                //print("Maximum number of tracked images before: \(configuration.maximumNumberOfTrackedImages)")
                self?.sceneView.session.run(configuration)
                configuration.maximumNumberOfTrackedImages = 10 //Seems to max out at 4 on a 6S. Still only 1 tracked at a time
                //print("Maximum number of tracked images after: \(configuration.maximumNumberOfTrackedImages)")
                
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }   // end ViewWillAppearn
    
    
    @IBAction func DoneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func setupImageDetection() {
        imageConfiguration = ARImageTrackingConfiguration()
        
        //print("Setting Image Detection...")
        //addReferenceImage()
    }
    
    func createReferenceImage(rawImage: UIImage) -> ARReferenceImage {
        print("Creating Referance Image...")
        let cgImage = rawImage.cgImage!
        let newRefImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.0762) //3 inches in meters
        newRefImage.name = "anchor index - \(globalImageCount)"
        return newRefImage
    } //END createReferenceImage
    
    func addReferenceImage(refImage: ARReferenceImage) {
        referenceImageSet.insert(refImage)
        print("Number of images in set : \(referenceImageSet.count)")
        imageConfiguration?.trackingImages = referenceImageSet
    } //END addReferenceImage
    
    func getData(){
        for objects in self.clusters{
            
            
            
            // Get Anchor
            if let userPicture = objects.value(forKey: "AnchorImage") as? PFFileObject {
                userPicture.getDataInBackground(block: {
                    (imageData: Data!, error: Error!) -> Void in
                    if (error == nil) {
                        let anchor = UIImage(data:imageData)
                        self.anchors.append(anchor!)
                        
                        
                        
                        // Get A
                        if let a_Image = objects.value(forKey:"A_Index") as? PFFileObject {
                            a_Image.getDataInBackground(block: {
                                (imageData: Data!, error: Error!) -> Void in
                                if (error == nil) {
                                    let a = UIImage(data:imageData)
                                    self.a_index.append(a!)
                                    // print("a_index accepted")
                                    //   print("Number of A_Index loaded: \(self.a_index.count)" )
                                }
                            })
                        }
                        // Get B
                        if let b_Image = objects.value(forKey:"B_Index") as? PFFileObject {
                            b_Image.getDataInBackground(block: {
                                (imageData: Data!, error: Error!) -> Void in
                                if (error == nil) {
                                    let b = UIImage(data:imageData)
                                    self.b_index.append(b!)
                                    //print("b_index accepted")
                                    //print("Number of B_Index loaded: \(self.b_index.count)" )
                                }
                            })
                        }
                        // Get C
                        if let c_Image = objects.value(forKey:"C_Index") as? PFFileObject {
                            c_Image.getDataInBackground(block: {
                                (imageData: Data!, error: Error!) -> Void in
                                if (error == nil) {
                                    let c = UIImage(data:imageData)
                                    self.c_index.append(c!)
                                    // print("c_index accepted")
                                    // print("Number of C_Index loaded: \(self.c_index.count)" )
                                }
                            })
                        }
                        // Get D
                        if let d_Image = objects.value(forKey:"D_Index") as? PFFileObject {
                            d_Image.getDataInBackground(block: {
                                (imageData: Data!, error: Error!) -> Void in
                                if (error == nil) {
                                    let d = UIImage(data:imageData)
                                    self.d_index.append(d!)
                                    // print("d_index accepted")
                                    //print("Number of D_Index loaded: \(self.d_index.count)" )
                                }
                            })
                        }
                        // Get E
                        if let e_Image = objects.value(forKey:"E_Index") as? PFFileObject {
                            e_Image.getDataInBackground(block: {
                                (imageData: Data!, error: Error!) -> Void in
                                if (error == nil) {
                                    let e = UIImage(data:imageData)
                                    self.e_index.append(e!)
                                    // print("e_index accepted")
                                    //print("Number of E_Index loaded: \(self.e_index.count)" )
                                }
                            })
                        }
                        // Get F
                        if let f_Image = objects.value(forKey:"F_Index") as? PFFileObject {
                            f_Image.getDataInBackground(block: {
                                (imageData: Data!, error: Error!) -> Void in
                                if (error == nil) {
                                    let f = UIImage(data:imageData)
                                    self.f_index.append(f!)
                                    // print("f_index accepted")
                                    //    print("Number of F_Index loaded: \(self.f_index.count)" )
                                }
                            })
                        }
                        // Get G
                        if let g_Image = objects.value(forKey:"G_Index") as? PFFileObject {
                            g_Image.getDataInBackground(block: {
                                (imageData: Data!, error: Error!) -> Void in
                                if (error == nil) {
                                    let g = UIImage(data:imageData)
                                    self.g_index.append(g!)
                                    //print("g_index accepted")
                                    //    print("Number of G_Index loaded: \(self.g_index.count)" )
                                }
                            })
                        }
                        // Get H
                        if let h_Image = objects.value(forKey:"H_Index") as? PFFileObject {
                            h_Image.getDataInBackground(block: {
                                (imageData: Data!, error: Error!) -> Void in
                                if (error == nil) {
                                    let h = UIImage(data:imageData)
                                    self.h_index.append(h!)
                                    //print("h_index accepted")
                                    // print("Number of H_Index loaded: \(self.h_index.count)" )
                                }
                            })
                        }
                    }
                })
            }
        } // end for loop
        //print("Required scope for SupplyClustersToAR")
        //supplyClustersToAR()
        
        
        
    }
    
    func createCollageObjects() {
        for _ in anchors {
            print("Number of raw anchors stored before pop: \(self.anchors.count)")
            let tempAnchor = self.anchors.popLast()
            
            print("Number of raw anchors stored after pop: \(self.anchors.count)")
            print("Going in Raw!")
            if tempAnchor != nil {
                //Creates the reference image from parse data and adds it to the set
                let newRefImg = createReferenceImage(rawImage: tempAnchor!)
                addReferenceImage(refImage: newRefImg)
                //Creates a new collageObject then adds it to the array of them
                let newCollageObject = collageObject(ARAnchor: newRefImg, UIAnchor: tempAnchor!, a_Image: self.a_index.popLast()!, b_Image: self.b_index.popLast()!, c_Image: self.c_index.popLast()!, d_Image: self.d_index.popLast()!, e_Image: self.e_index.popLast()!, f_Image: self.f_index.popLast()!, g_Image: self.g_index.popLast()!, h_Image: self.h_index.popLast()!)
                collageObjects.append(newCollageObject)
            } else {
                print("ERROR! Can't make ARRefImg or CollageObject! Raw RefImg was nil!")
            }
            
            //Prints the number of collage objects in the master array, per itteration
            print("CollageObject Array Count: \(self.collageObjects.count)")
        }
    }
    
    //    // passes Anchor image array as well as collage arrays
    //    func supplyClustersToAR() {
    //        var index = 0
    //
    //        // laod into collageOIbjects class
    //
    //        //for anchor in anchors {
    //           // var anchorImage = anchor
    //           // var aImage = a[index]
    //        //var counter = 0
    //
    //        for anchor in anchors{
    //
    //            guard let cgImg = anchors[index].cgImage else { return }
    //            let ARRefImg = ARReferenceImage(cgImg, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.0762) //3 inches in meters
    //
    //            //collageObjects[index].ARAnchor = ARRefImg
    //            collageObjects[index].UIAnchor = anchors[index]
    //            collageObjects[index].a_Image = a_index[index]
    //            collageObjects[index].b_Image = b_index[index]
    //            collageObjects[index].c_Image = c_index[index]
    //            collageObjects[index].d_Image = d_index[index]
    //            collageObjects[index].e_Image = e_index[index]
    //            collageObjects[index].f_Image = f_index[index]
    //            collageObjects[index].g_Image = g_index[index]
    //            collageObjects[index].h_Image = h_index[index]
    //
    //            index += 1
    //        }
    //
    //            self.setupImageDetection()
    //
    //            if let configuration = imageConfiguration {
    //                sceneView.session.run(configuration)
    //
    //
    //            } //END if let
    //       // } //END for anchor
    //    } //END supplyClustersToAR()
    
    //Handles a found IMAGE
    func handleFoundImage(_ imageAnchor: ARImageAnchor, _ node: SCNNode, collageName: String) {
        //let name = imageAnchor.referenceImage.name!
        var topRowPopulated = false //Used for title positioning above collage
        //print("Found image: \(name)")
        var collageIndex = -1
        var collageCount = 0
        
        let size = imageAnchor.referenceImage.physicalSize
        let sizeBig = CGSize(width: size.width * 1.25, height: size.height * 1.25)
        if let imageNode = makeImage(size: sizeBig) {
            node.addChildNode(imageNode)
            node.opacity = 1
            //print("Image matches size")
            
            for _ in collageObjects {
                if collageObjects[collageCount].ARAnchor == imageAnchor.referenceImage {
                    collageIndex = collageCount
                    print("IMAGE MATCHED WITH COLLAGEOBJECTS ARRAY!")
                }
                collageCount += 1
            }
            
            let name = collageObjects[collageIndex].title
            
            //Adds any applicable collage images
            if let collageNode = makeCollageImage(image: collageObjects[collageIndex].a_Image, size: size, name: name, positionIndex: 0) {
                imageNode.addChildNode(collageNode)
                imageNode.opacity = 1
                topRowPopulated = true //Will shift the title up later
            }
            if let collageNode = makeCollageImage(image: collageObjects[collageIndex].b_Image, size: size, name: name, positionIndex: 1) {
                imageNode.addChildNode(collageNode)
                imageNode.opacity = 1
                topRowPopulated = true //Will shift the title up later
            }
            if let collageNode = makeCollageImage(image: collageObjects[collageIndex].c_Image, size: size, name: name, positionIndex: 2) {
                imageNode.addChildNode(collageNode)
                imageNode.opacity = 1
                topRowPopulated = true //Will shift the title up later
            }
            if let collageNode = makeCollageImage(image: collageObjects[collageIndex].d_Image, size: size, name: name, positionIndex: 3) {
                imageNode.addChildNode(collageNode)
                imageNode.opacity = 1
            }
            if let collageNode = makeCollageImage(image: collageObjects[collageIndex].e_Image, size: size, name: name, positionIndex: 4) {
                imageNode.addChildNode(collageNode)
                imageNode.opacity = 1
            }
            if let collageNode = makeCollageImage(image: collageObjects[collageIndex].f_Image, size: size, name: name, positionIndex: 5) {
                imageNode.addChildNode(collageNode)
                imageNode.opacity = 1
            }
            if let collageNode = makeCollageImage(image: collageObjects[collageIndex].g_Image, size: size, name: name, positionIndex: 6) {
                imageNode.addChildNode(collageNode)
                imageNode.opacity = 1
            }
            if let collageNode = makeCollageImage(image: collageObjects[collageIndex].h_Image, size: size, name: name, positionIndex: 7) {
                imageNode.addChildNode(collageNode)
                imageNode.opacity = 1
            }
            

//            if let collageNode = makeCollageImage(size: size, name: name, positionIndex: 0) {
//                imageNode.addChildNode(collageNode)
//                imageNode.opacity = 1
//                topRowPopulated = true //Will shift the title up later
//            }
//            if let collageNode = makeCollageImage(size: size, name: name, positionIndex: 1) {
//                imageNode.addChildNode(collageNode)
//                imageNode.opacity = 1
//                topRowPopulated = true //Will shift the title up later
//            }
//            if let collageNode = makeCollageImage(size: size, name: name, positionIndex: 2) {
//                imageNode.addChildNode(collageNode)
//                imageNode.opacity = 1
//                topRowPopulated = true //Will shift the title up later
//            }
//            if let collageNode = makeCollageImage(size: size, name: name, positionIndex: 3) {
//                imageNode.addChildNode(collageNode)
//                imageNode.opacity = 1
//            }
//            if let collageNode = makeCollageImage(size: size, name: name, positionIndex: 4) {
//                imageNode.addChildNode(collageNode)
//                imageNode.opacity = 1
//            }
//            if let collageNode = makeCollageImage(size: size, name: name, positionIndex: 5) {
//                imageNode.addChildNode(collageNode)
//                imageNode.opacity = 1
//            }
//            if let collageNode = makeCollageImage(size: size, name: name, positionIndex: 6) {
//                imageNode.addChildNode(collageNode)
//                imageNode.opacity = 1
//            }
//            if let collageNode = makeCollageImage(size: size, name: name, positionIndex: 7) {
//                imageNode.addChildNode(collageNode)
//                imageNode.opacity = 1
//            }
            
            //Adds title text
            let text = SCNText(string: name, extrusionDepth: 0.001)
            text.font = UIFont.systemFont(ofSize: 1.0)
            text.flatness = 0.005
            text.firstMaterial?.diffuse.contents = UIColor.white
            let textNode = SCNNode(geometry: text)
            let fontScale = Float(0.04)
            textNode.scale = SCNVector3(fontScale, fontScale, fontScale)
            
            //Centers the Text
            let (min, max) = textNode.boundingBox
            let dx = min.x + 0.5 * (max.x - min.x)
            let dy = min.y + 0.5 * (max.y - min.y)
            let dz = min.z + 0.5 * (max.z - min.z)
            textNode.pivot = SCNMatrix4MakeTranslation(dx, dy, dz)
            
//            //Creates a copy of what the top title position would be
//            var topTitlePos = textNode.position.y
//            topTitlePos += Float(fontScale) + Float(0.10)
//            print("\(topTitlePos))")
            
            //Offsets the text y position based on collage image placements
            if topRowPopulated {
                textNode.position.y = Float(0.15)
            } else {
                textNode.position.y = Float(0.06)
            }
            
            //let (_, max) = textNode.boundingBox
            //textNode.position.x -= (Float(max.x) / 2.0)
            
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
    } //END handleFoundImage()
    
} //END class

    // -----
    
    extension ARViewController: ARSCNViewDelegate {
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            DispatchQueue.main.async {} //Hide things callback
            if let imageAnchor = anchor as? ARImageAnchor {
                handleFoundImage(imageAnchor, node, collageName: "anchor")
                /*
            } else if let objectAnchor = anchor as? ARObjectAnchor { //This is for finding objects, which probably we won't need
                //handleFoundObject(ObjectAnchor, node)
                */
            }
        } //renderer()
}
        


        
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
        
private func makeCollageImage(image: UIImage, size: CGSize, name: String, positionIndex: Int) -> SCNNode? {
            
            //Set the box size to the length
            var boxSize = size.width
            //If the height is longer, set it to that
            if (size.height > size.width) {
                boxSize = size.height
            }
            
            //print("Preparing size: width: \(size.width) height: \(size.height)")
            let newImage = SCNPlane(width: boxSize, height: boxSize)
//            let tempImage = UIImage(named: name + "_" + String(positionIndex))
//            if (tempImage == nil) {
//                return nil
//            }
    
            //Going to need a switch statement to determine which letter index array to look in for the UIImage
            
            //name paramater will be changed to array index location
            //index location will be specifying collageIndex
            
            //newImage.firstMaterial?.diffuse.contents = //Gets image associated with anchor image  - NEW LINE
            newImage.firstMaterial?.diffuse.contents = image
            print("Adding Collage Image...")
            newImage.firstMaterial?.lightingModel = .constant
            let newImageNode = SCNNode(geometry: newImage)
            newImageNode.eulerAngles.x = -.pi / 2
            
            let spacing = 0.01
            
            //Based on the index, find the relative offset position
            switch positionIndex {
            case 0:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x -= Float(boxSize) + Float(spacing)
                newImageNode.position.y += Float(boxSize) + Float(spacing)
                //newImageNode.position.z = 0.0
            case 1:
                newImageNode.rotation.w = 0.0
                //newImageNode.position.x = 0.0
                newImageNode.position.y += Float(boxSize) + Float(spacing)
                //newImageNode.position.z = 0.0
            case 2:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x += Float(boxSize) + Float(spacing)
                newImageNode.position.y += Float(boxSize) + Float(spacing)
                //newImageNode.position.z = 0.0
            case 3:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x += Float(boxSize) + Float(spacing)
                //newImageNode.position.y = 0.0
                //newImageNode.position.z = 0.0
            case 4:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x += Float(boxSize) + Float(spacing)
                newImageNode.position.y -= Float(boxSize) + Float(spacing)
                //newImageNode.position.z = 0.0
            case 5:
                newImageNode.rotation.w = 0.0
                //newImageNode.position.x = 0.0
                newImageNode.position.y -= Float(boxSize) + Float(spacing)
                //newImageNode.position.z = 0.0
            case 6:
                newImageNode.rotation.w = 0.0
                newImageNode.position.x -= Float(boxSize) + Float(spacing)
                newImageNode.position.y -= Float(boxSize) + Float(spacing)
                //newImageNode.position.z = 0.0
            case 7:
                newImageNode.rotation.w = 0.0
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



