//
//  AddPictureViewController.swift
//  GalleryList
//
//  Created by Heather Cates on 11/25/17.
//  Copyright © 2017 Heather Cates. All rights reserved.
//

import UIKit

class AddPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var galleryImageTextFeild: UITextField!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var galleryItem : GalleryItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if(galleryItem != nil){
            galleryImageView.image = UIImage(data: galleryItem!.photo as! Data)
            galleryImageTextFeild.text = galleryItem?.photoText
            addUpdateButton.setTitle(" update ", for: .normal)
        }
        else{
            deleteButton.isHidden = true
        }
    }
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)    }
    
    @IBAction func photosButtonTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        galleryImageView.image = image
        //dismiss the view once image is set
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToGalleryTapped(_ sender: Any) {
        
        if (galleryItem != nil){
            galleryItem!.photoText = galleryImageTextFeild.text
            galleryItem!.photo = UIImagePNGRepresentation(galleryImageView.image!) as NSData?        }
        else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let galleryItem = GalleryItem(context: context)
            galleryItem.photoText = galleryImageTextFeild.text
            galleryItem.photo = UIImagePNGRepresentation(galleryImageView.image!) as NSData?
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteFromGalleryTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(galleryItem!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
