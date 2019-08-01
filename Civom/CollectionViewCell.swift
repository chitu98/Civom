//
//  CollectionViewCell.swift
//  Civom
//
//  Created by Chitransh on 25/07/19.
//  Copyright © 2019 LateralX. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    // this is clear color view and superview to all
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var visibleView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCat: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //design changes for mainView
        self.mainView.layer.cornerRadius = 30.0
        self.mainView.layer.shadowColor = UIColor.black.cgColor
        self.mainView.layer.shadowOpacity = 0.3
        self.mainView.layer.shadowOffset = CGSize(width: 2, height: 2)
       // self.mainView.layer.shadowRadius = 6
      //  self.mainView.layer.shadowPath = UIBezierPath(rect: self.mainView.bounds).cgPath
        self.mainView.layer.shouldRasterize = true
        
        
        //design changes for visibleView
        //self.visibleView.layer.cornerRadius = 20.0
        //self.visibleView.layer.masksToBounds = true
        
        //design changes for imgView
        self.imgView.contentMode = .scaleAspectFill
        self.imgView.layer.cornerRadius = 20.0
        
        
       
    }

}
