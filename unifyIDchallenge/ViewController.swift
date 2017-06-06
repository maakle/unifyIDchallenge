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
    
    //Objects
    let keychain = KeychainSwift()
    
    //Variables
    private var index = 0
    private var arrayForImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designButton()
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
        for i in 0..<10 {
            let image = array[i]
            if let data = UIImagePNGRepresentation(image) {
                keychain.set(data, forKey: "Picture: \(i+1)")
                print("Picture saved")
                if i == 0 {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    //MARK: -  UI
    func designButton(){
        //Set Border, Color and White for loginButton
        authenticateButton.layer.cornerRadius = 4
    }
    
}

