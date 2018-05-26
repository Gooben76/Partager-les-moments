//
//  PhotoController.swift
//  Partager les moments
//
//  Created by Benoît Goossens on 26/05/18.
//  Copyright © 2018 Benoît Goossens. All rights reserved.
//

import UIKit

class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var partagerButton: UIBarButtonItem!
    @IBOutlet weak var photoAPartager: UIImageView!
    @IBOutlet weak var textAPartager: UITextView!
    
    let texteVide = "Entrez votre texte ..."
    var imagePicker: UIImagePickerController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        miseEnPlace()
    }

    func miseEnPlace(){
        photoAPartager.contentMode = .scaleAspectFit
        photoAPartager.image = #imageLiteral(resourceName: "Superman-facebook.svg")
        photoAPartager.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(cliquerPhoto))
        photoAPartager.addGestureRecognizer(tap)
        
        textAPartager.text = texteVide
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.allowsEditing = true
        
        textAPartager.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textAPartager.text == texteVide {
            textAPartager.text = ""
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var image:UIImage?
        if let editee = info[UIImagePickerControllerEditedImage] as? UIImage {
            image = editee
        } else if let originale = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image = originale
        }
        photoAPartager.image = image
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    
    @objc func cliquerPhoto(){
        guard imagePicker != nil else {return}
        let alert = UIAlertController(title: "Prendre une photo", message: "Sélection du média", preferredStyle: .actionSheet)
        let appareil = UIAlertAction(title: "Appareil photo", style: .default) { (act) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker?.sourceType = .camera
                self.present(self.imagePicker!, animated: true, completion: nil)
            }
        }
        let librairie = UIAlertAction(title: "Bibliothèque", style: .default) { (act) in
            self.imagePicker?.sourceType = .photoLibrary
            self.present(self.imagePicker!, animated: true, completion: nil)
        }
        let annuler = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alert.addAction(appareil)
        alert.addAction(librairie)
        alert.addAction(annuler)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let pop = alert.popoverPresentationController{
                pop.sourceView = self.view
                pop.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
                pop.permittedArrowDirections = []
                
            }
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func partagerClick(_ sender: Any) {
        var activites :[Any] = [Any]()
        if let image = photoAPartager.image, image != #imageLiteral(resourceName: "Superman-facebook.svg") {
            activites.append(image)
        }
        if textAPartager.text != texteVide, textAPartager.text != "" {
            activites.append(textAPartager.text)
        }
        
        let activite = UIActivityViewController(activityItems: activites, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let pop = activite.popoverPresentationController{
                pop.sourceView = self.view
                pop.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
                pop.permittedArrowDirections = []
            }
        }
        self.present(activite, animated: true) {
            self.miseEnPlace()
        }
    }
    
}
