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
    
    
//    ACTIONS
    
    @IBAction func onSubmit(_ sender: Any) {
        
        // initialization of new table "collage"
         let collage = PFObject(className: "collage")
        
        //  store image into a PFFile
        let anchor = AnchorImage.image!.pngData()
        let file = PFFileObject(data: anchor!)
        
        //  store image into a PFFile
        let A = A_Image.image!.pngData()
        let A_file = PFFileObject(data: A!)
        
        let B = B_Image.image!.pngData()
        let B_file = PFFileObject(data: B!)
        
        let C = C_Image.image!.pngData()
        let C_file = PFFileObject(data: C!)
        
        let D = D_Image.image!.pngData()
        let D_file = PFFileObject(data: D!)
        
        let E = E_Image.image!.pngData()
        let E_file = PFFileObject(data: E!)
        
        let F = F_Image.image!.pngData()
        let F_file = PFFileObject(data: F!)
        
        let G = A_Image.image!.pngData()
        let G_file = PFFileObject(data: G!)
        
        let H = H_Image.image!.pngData()
        let H_file = PFFileObject(data: H!)
        
        //  add that PFFile to parse under column Anchor
        // nil checking
        if (AnchorImage.image == defaultImage){
          print("Please select an image.")
        } else {
            collage["AnchorImage"] = file
            //  submit all contents to
            collage["A_Index"] = A_file
            collage["B_Index"] = B_file
            collage["C_Index"] = C_file
            collage["D_Index"] = D_file
            collage["E_Index"] = E_file
            collage["F_Index"] = F_file
            collage["G_Index"] = G_file
            collage["H_Index"] = H_file
            
            // save results to Parse
            collage.saveInBackground{ (success, error) in
                if success {
                    print ("Saved Successfully.")
                } else {
                    print("Image not saved.")
                    print(error as Any)
                }
            }
            self.dismiss(animated: true, completion: nil)
          }
        
        //  Pass a static image to AR Scene for testing creation on AR
        
        staticTestImage = AnchorImage.image
        
        // SEGUE FOR TESTING PURPOSES AR
        
        performSegue(withIdentifier: "ARViewController",   sender: nil)
        
        }
        
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  set destination View Controller
        let destinationVC = segue.destination as! ARViewController
        destinationVC.passedImage = staticTestImage
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
        

        //  Queries the database for collage information
        let query = PFQuery(className: "collage")
        
        query.includeKeys(["AnchorImage", "A_Index", "B_Index", "C_Index", "D_Index", "E_Index", "F_Index", "G_Index", "H_Index" ])
        query.limit = 20
        
        //        anchorImage.image = (query["AnchorImage"] as! [PJObject] ?? []
        
        query.getFirstObjectInBackground { (collage: PFObject?, error: Error?) -> Void in
            if let error = error {
                //The query returned an error
                print(error.localizedDescription)
            } else {
                //The object has been retrieved
                if let userPicture = collage?["AnchorImage"] as? PFFileObject {
                    userPicture.getDataInBackground { (imageData: Data?, error: Error?) -> Void in
                        if (error == nil) {
                            // Test Statement to see which image is being loaded into Parse
                            // self.A_Image.image = UIImage(data:imageData!)
                        }
                    }
                }
 
                    
                    
            }
        }
    
        
        //  DefaultImage is set to anchor image. This is used to tell if the user has entered a new image
        
        defaultImage = AnchorImage.image
        imagePickerController.delegate = self
    
 
    }
}
