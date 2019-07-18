//
//  LaunchScreenController.swift
//  Civom
//
//  Created by Chitransh on 17/07/19.
//  Copyright © 2019 LateralX. All rights reserved.
//

import UIKit

class LaunchScreenController: UIViewController {

    let backgroundImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        // Do any additional setup after loading the view.
    }
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "Splashscreen")
        view.sendSubviewToBack(backgroundImageView)
   
    }

}
