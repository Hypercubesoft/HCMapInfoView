//
//  MapInfoGreenView.swift
//  HCMapInfoView
//
//  Created by Vladimir Dinic on 10/19/17.
//  Copyright © 2017 Vladimir Dinic. All rights reserved.
//

import UIKit

class MapInfoGreenView: HCMapInfoView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func update(withAnnotation annotation:HCAnnotation)
    {
        self.titleLabel.text = annotation.title
        self.subtitleLabel.text = annotation.subtitle
    }
    
    @IBAction func pinPressedAction(_ sender: Any)
    {
        print("Pressed green pin")
    }

}
