//
//  MapInfoView.swift
//  HCMapInfoView
//
//  Created by Hypercube on 9/14/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit

class MapInfoAnimalView: HCMapInfoView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func update(withAnnotation annotation:HCAnnotation)
    {
        self.titleLabel.text = annotation.title
        self.subtitleLabel.text = annotation.subtitle
        self.ageLabel.text = "No age"
    }
    
    func update(withAnimal animal:Animal)
    {
        self.update(withAnnotation: animal)
        self.ageLabel.text = "Age: \(animal.age)"
        self.imageView.image = animal.image
    }
    
    @IBAction func pinPressedAction(_ sender: Any)
    {
        print("Pressed blue pin")
    }
}
