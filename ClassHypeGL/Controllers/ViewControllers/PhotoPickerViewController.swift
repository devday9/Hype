//
//  PhotoPickerViewController.swift
//  ClassHypeGL
//
//  Created by Deven Day on 10/8/20.
//

import UIKit

protocol PhotoSelectorDelegate: AnyObject {
    func photoPickerSelected(image: UIImage)
}

class PhotoPickerViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var selectPhotoButton: UIButton!
    
    
    
    //MARK: - Properties
    let imagePicker = UIImagePickerController()
    weak var delegate: PhotoSelectorDelegate?
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Actions
    @IBAction func selectphotoButtonTapped(_ sender: Any) {
        let alertVC = UIAlertController(title: "Add a Photo", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.imagePicker.dismiss(animated: true)
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.openCamera()
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            self.openPhotoLibrary()
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(cameraAction)
        alertVC.addAction(photoLibraryAction)
        
        present(alertVC, animated: true)
    }
    
    //MARK: - Helper Funcitons
    func setupViews() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.backgroundColor = .lightGray
        imagePicker.delegate = self
    }
}//END OF CLASS

//MARK: - Extensions
extension PhotoPickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true)
        } else {
            let alertVC = UIAlertController(title: "Camera Not Accessible", message: "You will need to make sure your camera is accessible to use this feature.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true)
        }
    }
    
    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true)
        } else {
            let alertVC = UIAlertController(title: "Photo Library Not Accessible", message: "You will need to make sure your photo library is accessible to use this feature.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            guard let delegate = delegate else {return}
            delegate.photoPickerSelected(image: pickedImage)
            photoImageView.image = pickedImage
        }
        picker.dismiss(animated: true)
    }
}//END OF EXTENSION
