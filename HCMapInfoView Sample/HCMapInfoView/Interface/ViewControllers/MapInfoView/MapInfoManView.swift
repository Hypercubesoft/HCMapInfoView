//
//  MapInfoView.swift
//  HCMapInfoView
//
//  Created by Hypercube on 9/14/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit

class MapInfoManView: HCMapInfoView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    func update(withAnnotation annotation:HCAnnotation)
    {
        self.titleLabel.text = annotation.title
        self.subtitleLabel.text = annotation.subtitle
    }
    
    func update(withMan man:Man)
    {
        self.update(withAnnotation: man)
        self.pointsLabel.text = "Points: \(man.userPoints)"
        self.imageView.image = man.userImage
    }
    
    @IBAction func pinPressedAction(_ sender: Any)
    {
        print("Pressed red pin")
    }
    
}
