//
//  PhotoController.swift
//  Partager les moments
//
//  Created by Benoît Goossens on 26/05/18.
//  Copyright © 2018 Benoît Goossens. All rights reserved.
//

import UIKit

class PhotoController: UIViewController {

    @IBOutlet weak var partagerButton: UIBarButtonItem!
    @IBOutlet weak var photoAPartager: UIImageView!
    @IBOutlet weak var textAPartager: UITextView!
    
    let texteParatger = "Entrez votre texte ..."
    
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
        
        textAPartager.text = texteParatger
    }
    
    @objc func cliquerPhoto(){
        
    }
    
    @IBAction func partagerClick(_ sender: Any) {
    }
    
}
