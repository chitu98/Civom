//
//  ARCollectionViewCell.swift
//  Civom
//
//  Created by Chitransh on 10/09/19.
//  Copyright © 2019 LateralX. All rights reserved.
//

import UIKit

class ARCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
        //@IBOutlet weak var ObjTitle: UILabel!
    @IBOutlet weak var ObjTitle: UILabel!
    @IBOutlet weak var ObjThumbnail: UIImageView!
        @IBOutlet weak var objectBtn: UIButton!
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            
            //design changes for mainView
                   self.mainView.layer.cornerRadius = 50.0
                   self.mainView.layer.shadowColor = UIColor.black.cgColor
                   self.mainView.layer.shadowOpacity = 0.3
                   self.mainView.layer.shadowOffset = CGSize(width: 2, height: 2)
                  // self.mainView.layer.shadowRadius = 6
                 //  self.mainView.layer.shadowPath = UIBezierPath(rect: self.mainView.bounds).cgPath
                   self.mainView.layer.shouldRasterize = true
                   
        }

    }
