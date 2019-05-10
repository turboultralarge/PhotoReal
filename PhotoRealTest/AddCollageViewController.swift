//
//  CreationVC.swift
//  PhotoReal
//
//  Created by Anthony Ronca on 4/4/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import Photos

class AddCollageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //  VARIABLES USED:
    
    let imagePickerController = UIImagePickerController()
    var passedImage: UIImage!
    var selectedIndex = "none"
    var defaultImage: UIImage!
    var staticTestImage: UIImage?
    
    //    OUTLETS
    
    @IBOutlet var AnchorImage: UIImageView! //  Middle image AKA Anchor for AR scene
    @IBOutlet var A_Image: UIImageView!  //  image at [-1,1]
    @IBOutlet var B_Image: UIImageView!  //  image at [0,1]
    @IBOutlet var C_Image: UIImageView!  //  image at [1,1]
    @IBOutlet var D_Image: UIImageView!  //  image at [1,0]
    @IBOutlet var E_Image: UIImageView!  //  image at [1,-1]
    @IBOutlet var F_Image: UIImageView!  //  image at [0,-1]
    @IBOutlet var G_Image: UIImageView!  //  image at [-1,-1]
    @IBOutlet var H_Image: UIImageView!  //  image at [-1,0]
    
    var uiimageviews = [UIImageView]()
    
    
    //    ACTIONS
    
    @IBAction func onSubmit(_ sender: Any) {
        
        // initialization of new table "collage"
        //let collage = PFObject(className: "cluster")
        
        //  store image into a PFFile
        let anchor = AnchorImage.image
        //let file = PFFileObject(data: anchor!)
        
        //  store image into a PFFile
        let A = A_Image.image
        //let A_file = PFFileObject(data: A!)
        
        let B = B_Image.image
       // let B_file = PFFileObject(data: B!)
        
        let C = C_Image.image
        //let C_file = PFFileObject(data: C!)
        
        let D = D_Image.image
        //let D_file = PFFileObject(data: D!)
        
        let E = E_Image.image
        //let E_file = PFFileObject(data: E!)
        
        let F = F_Image.image
        //let F_file = PFFileObject(data: F!)
        
        let G = A_Image.image
       // let G_file = PFFileObject(data: G!)
        
        let H = H_Image.image
       // let H_file = PFFileObject(data: H!)
        
        //  add that PFFile to parse under column Anchor
        // nil checking
        if (AnchorImage.image == defaultImage){
            print("Please select an image.")
        } else {
            print("Saving array...")
            
            let imageArray = [anchor, A, B, C, D, E, F, G, H]
            
            let imageColl = imageCollection()
            
            imageColl.images = imageCollection.imagesToPFObject(arrayOfImages: imageArray as? [UIImage])
            
            imageColl.saveInBackground { (sucess, error) in
                if let error = error{
                    print(error.localizedDescription)
                } else{
                    print("Hell ya!!!! 😁  - SAVED ")
                    self.performSegue(withIdentifier: "ARViewController",   sender: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  set destination View Controller
        _ = segue.destination as! ARViewController
        //destinationVC.passedImage = staticTestImage
    }
    
    
    
    @IBAction func onAnchorImage(_ sender: Any) {
        //  Change index for appropriate case
        selectedIndex = "Anchor"
        
        //  Allow user to select or take a picture
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        //  If camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    @objc internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        
        //  Case is selected based on which imageView is selected
        switch(selectedIndex) {
            
        case "Anchor"  :
            print("Anchor case entered")
            self.AnchorImage.image = scaledImage
            break;
        case "A_Index"  :
            print("A_Index case entered")
            A_Image.image = image;
            break;
        //  Selection of collage index to change
        case "B_Index"  :
            print("B_Index case entered")
            B_Image.image = image;
            break;
        //  Selection of collage index to change
        case "C_Index"  :
            print("C_Index case entered")
            C_Image.image = image;
            
            break;
        //  Selection of collage index to change
        case "D_Index"  :
            print("D_Index case entered")
            D_Image.image = image;
            break;
        //  Selection of collage index to change
        case "E_Index"  :
            print("E_Index case entered")
            E_Image.image = image;
            break;
        //  Selection of collage index to change
        case "F_Index"  :
            print("F_Index case entered")
            F_Image.image = image;
            break;
        //  Selection of collage index to change
        case "G_Index"  :
            print("G_Index case entered")
            G_Image.image = image;
            break;
        //  Selection of collage index to change
        case "H_Index"  :
            print("H_Index case entered")
            H_Image.image = image;
            break;
        default :
            print("error - default")
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    //  When Image at Index A is selected:
    @IBAction func onImageA(_ sender: Any) {
        //  Change index for appropriate case
        selectedIndex = "A_Index"
        callPicker()
    }
    
    @IBAction func onImageB(_ sender: Any) {
        //  Change index for appropriate case
        selectedIndex = "B_Index"
        //  Allow user to select or take a photo
        callPicker()
    }
    
    @IBAction func onImageC(_ sender: Any) {
        //  Change index for appropriate case
        selectedIndex = "C_Index"
        //  Allow user to select or take a photo
        callPicker()
    }
    @IBAction func onImageD(_ sender: Any) {
        //  Change index for appropriate case
        selectedIndex = "D_Index"
        //  Allow user to select or take a photo
        callPicker()
    }
    @IBAction func onImageE(_ sender: Any) {
        //  Change index for appropriate case
        selectedIndex = "E_Index"
        //  Allow user to select or take a photo
        callPicker()
    }
    
    @IBAction func onImageF(_ sender: Any) {
        //  Change index for appropriate case
        selectedIndex = "F_Index"
        //  Allow user to select or take a photo
        callPicker()
    }
    
    @IBAction func onImageG(_ sender: Any) {
        //  Change index for appropriate case
        selectedIndex = "G_Index"
        //  Allow user to select or take a photo
        callPicker()
    }
    
    @IBAction func onImageH(_ sender: Any) {
        //  Change index for appropriate case
        selectedIndex = "H_Index"
        //  Allow user to select or take a photo
        callPicker()
    }
    
    func callPicker(){
        //  Allow user to select or take a picture
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
            
        }else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func tableView(_ tableView : UITableView, didSelectRowAt indexPath: IndexPath ){
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  DefaultImage is set to anchor image. This is used to tell if the user has entered a new image
        defaultImage = AnchorImage.image
        imagePickerController.delegate = self
        
        uiimageviews = [AnchorImage, A_Image, B_Image, C_Image, D_Image, E_Image, F_Image, G_Image, H_Image]
        
    }
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
