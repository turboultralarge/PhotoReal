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

class CreationVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //  VARIABLES USED:
    
    let imagePickerController = UIImagePickerController()
    var passedImage: UIImage!
    
//    OUTLETS
    
    @IBOutlet var AnchorImage: UIImageView! //  Middle image AKA Anchor for AR scene
    @IBOutlet var A_Image: UIImageView!  //  image at [0,0]
    @IBOutlet var B_Image: UIImageView!  //  image at [0,1]
    @IBOutlet var C_Image: UIImageView!  //  image at [0,2]
    @IBOutlet var D_Image: UIImageView!  //  image at [2,2]
    @IBOutlet var E_Image: UIImageView!  //  image at [3,2]
    @IBOutlet var F_Image: UIImageView!  //  image at [3,1]
    @IBOutlet var G_Image: UIImageView!  //  image at [3,0]
    @IBOutlet var H_Image: UIImageView!  //  image at [2,0]
    
    
//    ACTIONS
    
    @IBAction func onSubmit(_ sender: Any) {
        
         let collage = PFObject(className: "collage")
        
        passedImage = AnchorImage.image
    
          let imageData = AnchorImage.image!.pngData()
          let file = PFFileObject(data: imageData!)
        
          collage["Anchor"] = file
        
       // collage["Anchor"] = passedImage
        
        collage.saveInBackground{ (success, error) in
            if success {
                print ("Saved Successfully.")
                //  performSegue(withIdentifier: "ImageToAR", sender: Image.self)
              self.dismiss(animated: true, completion: nil)
            } else {
                print("Image not saved.")
                print(error)
            }
        }
        
        //  performSegue(withIdentifier: "ImageToAR", sender: Image.self)
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ViewController
        destinationVC.passedImage = sender as? UIImage
        
    }
    
    
    
    @IBAction func onAnchorImage(_ sender: Any) {
        
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
    
    
   @objc internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    
    let image = info[.editedImage] as! UIImage
    
    let size = CGSize(width: 300, height: 300)
    let scaledImage = image.af_imageAspectScaled(toFill: size)
    
    self.AnchorImage.image = scaledImage
    
    A_Image.image = image;
    
        dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView : UITableView, didSelectRowAt indexPath: IndexPath ){
        
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        
      /*  func checkPermission() {
            let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
            switch photoAuthorizationStatus {
            case .authorized:
                print("Access is granted by user")
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({
                    (newStatus) in
                    print("status is \(newStatus)")
                    if newStatus ==  PHAuthorizationStatus.authorized {
                        /* do stuff here */
                        print("success")
                    }
                })
                print("It is not determined until now")
            case .restricted:
                // same same
                print("User do not have access to photo album.")
            case .denied:
                // same same
                print("User has denied the permission.")
            @unknown default:
                print("uh oh youre not suppose to be here")
            }
        }
    
        
        imagePickerController.delegate = self
        
*/
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
