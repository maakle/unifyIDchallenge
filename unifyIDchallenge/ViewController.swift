//
//  ViewController.swift
//  unifyIDchallenge
//
//  Created by Mathias Klenk on 06/06/17.
//  Copyright © 2017 Mathias Klenk. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Outlets
    @IBOutlet weak var authenticateButton: UIButton!
    
    
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
    }
    
    //MARK: -  UI
    func designButton(){
        //Set Border, Color and White for loginButton
        authenticateButton.layer.cornerRadius = 4
    }
    
}

