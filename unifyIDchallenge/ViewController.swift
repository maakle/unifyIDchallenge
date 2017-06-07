//
//  ViewController.swift
//  unifyIDchallenge
//
//  Created by Mathias Klenk on 06/06/17.
//  Copyright © 2017 Mathias Klenk. All rights reserved.
//

import UIKit
import KeychainSwift

class ViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var authenticateButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityLabel: UILabel!
    
    //Objects
    let keychain = KeychainSwift()
    
    //Variables
    private var arrayForImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designButton()
        activityIndicator.isHidden = true
        
        //Turning of the synchronizing of the keychain function
        keychain.synchronizable = false
    }
    
    //MARK: - Functions
    @IBAction func authenticateButtonTapped(_ sender: Any) {
                
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.cameraFlashMode = .off
        imagePicker.cameraCaptureMode = .photo
        imagePicker.cameraDevice = .front
        imagePicker.showsCameraControls = false
        self.present(imagePicker, animated: true, completion: {
            
            // Foor loop for 10 pictures with a delay of 0.5s between it
            for i in 1..<11 {
                self.delayWithSeconds(0.5 * Double(i)) {
                    imagePicker.takePicture()
                }
                
            }
        })
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Picture has been taken")
        let imageTaken = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.arrayForImages.append(imageTaken)
        
        if self.arrayForImages.count == 10 {
            transformToDataAndSaveSecurely(array: self.arrayForImages)
        }
    }
    
    func transformToDataAndSaveSecurely(array: [UIImage]){
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            for i in 0..<10 {
                let image = array[i]
                if let data = UIImagePNGRepresentation(image) {
                    self.keychain.set(data, forKey: "picture\(i+1)", withAccess: .accessibleWhenUnlockedThisDeviceOnly) //most restrictive saving option
                    print("Picture saved")
                }
                if i == 9 {
                    self.activityLabel.isHidden = true
                    self.activityIndicator.isHidden = true
                    self.authenticateButton.isEnabled = true
                    self.authenticateButton.backgroundColor = UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0)
                    self.activityIndicator.stopAnimating()
                    self.arrayForImages.removeAll()
                    print("Array has been cleared & images are stored secure.")
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
        self.activityIndicator.isHidden = false
        self.activityLabel.isHidden = false
        self.authenticateButton.isEnabled = false
        self.authenticateButton.backgroundColor = UIColor.darkGray
        self.activityIndicator.startAnimating()
    }
    
    //MARK: -  UI
    func designButton(){
        //Set Border, Color and White for loginButton
        authenticateButton.layer.cornerRadius = 4
    }
}

