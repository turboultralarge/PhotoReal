//
//  ChooseImageViewController.swift
//  PhotoReal
//
//  Created by Travis Abendshien on 4/10/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import UIKit
import ARKit

class ChooseImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    

    @IBAction func addImageButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onConfirm(_ sender: AnyObject) {
        
        //let newRefImage = CGImage(
        getImage()
        
        
        
        //Return to previous View Controller
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var imgIndex = 0
        var newReferenceSet = Set<ARReferenceImage>()
        var documentsDirectory = getImageStorageDirectory()
        
        let newImage = info[.editedImage] as! UIImage
        saveImage(image: newImage, imgName: "Test")
        
        //let size = CGSize(width: 300, height: 300)
        //let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        //Displays the image on the screen
        imageView.image = newImage
        
        //Try and see if the image was saved
        //if let customImage = UIImage(fileName: "Test", type: "jpg") {
            
        //}
        
        
        
        //Prepares the image to go into a new ARReferenceImage object
        guard let cgImage = newImage.cgImage else { return }
        let width = CGFloat(cgImage.width)
        //guard let refSize = 0.0762 else { return }
        
        //Creates a new ARReferenceImage object from the image
        let newRefImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: width)
        
        //Temporary name for testing
        newRefImage.name = "Test"
        
        
        
        imgIndex += 1
        
        dismiss(animated: true, completion: nil)
    }
    
    //Return the user's Documents directory
    func getImageStorageDirectory() -> String {
        
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("CustomReferenceImages")
        
        //let url = NSURL(string: path)
        return path
        
        //let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //let documentDirectory = paths[0]
        //return documentDirectory
    }
    
    func saveImage(image: UIImage, imgName: String) {
        let fileManager = FileManager.default
        //NOTE: The get path logic is the same as in getImageStorageDirectory()
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("CustomReferenceImages")
        print("--------------------------")
        print("Path: \(path)")
        
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        
        
        let url = NSURL(string: path)
        
        print("URL: \(url)")
        
        let imagePath = url!.appendingPathComponent(imgName + ".jpg")
        let urlString: String = imagePath!.absoluteString
        let imageData = image.jpegData(compressionQuality: 1)
        
        getImage()
        
        fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
        
        print("--- Trying to save Image at \(urlString)")
        
    }
    
    
    //NOTE: Test.jpg is currently a placeholder, in the future it will
    //take in a name specified by the user and automatically detect
    //the file type.
    func getImage() {
        let fileManager = FileManager.default
        let imagePath = (self.getImageStorageDirectory() as NSString).appendingPathComponent("Test.jpg")
        
        if fileManager.fileExists(atPath: imagePath) {
            print("--- Image Save Confirmed at\(imagePath)")
        } else {
            print("--- Image Not Found at \(imagePath)")
        }
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
