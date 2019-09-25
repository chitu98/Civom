//
//  ProductinfoViewController.swift
//  Civom
//
//  Created by Chitransh on 12/09/19.
//  Copyright © 2019 LateralX. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ProductinfoViewController: UIViewController {
    //array for api
    var arrRes = [[String:AnyObject]]() //array of dictionary
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var titleProduct = ""
    var descProduct = ""
    var imgProduct = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start for api request
        Alamofire.request("http://35.154.220.170/api/assets").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar.arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
            }
        }
        
        let descProductPretty = descProduct.replacingOccurrences(of: "\\n ", with: "\n")
        //end for api request
        labelTitle.text = titleProduct
        labelDesc.text = descProductPretty
        
        let url = URL(string: imgProduct)
        productImage.kf.setImage(with: url)
        
        print(descProductPretty)
    }
    
    
}
