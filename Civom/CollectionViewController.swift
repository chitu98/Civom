//
//  CollectionViewController.swift
//  Civom
//
//  Created by Chitransh on 25/07/19.
//  Copyright © 2019 LateralX. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


//defining
struct ModelCollectionFlowLayout {
    var title:String = ""
    var image:UIImage!
    var desc:String = ""
}

class CollectionViewController: UIViewController {
   //array for static data
    var arrData = [ModelCollectionFlowLayout]()
    
   //array for api
     var arrRes = [[String:AnyObject]]() //array of dictionary

    @IBOutlet weak var bgGrsadientView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //gradient bg
        
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor.white.cgColor,
                        UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0).cgColor]
        layer.startPoint = CGPoint(x: 1,y: 0)
        layer.endPoint = CGPoint(x: 1,y: 0.6)
       // layer.locations = [0, 0.5]
    //    bgGradientView.layer.addSublayer(layer)
        
      //  collectData()
        
        //start for api request
        
        Alamofire.request("https://api.imgur.com/3/gallery/hot/viral/0.json").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["data"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.collectionView.reloadData()
                }
            }
        }
        //end for api request
        
        self.collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")

        //properties of UPCarouselFlowLayout.swift file to tweak
        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 140.0, height: collectionView.frame.size.height)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.8
        floawLayout.sideItemAlpha = 1.0
        floawLayout.spacingMode = .fixed(spacing: 5.0)
        collectionView.collectionViewLayout = floawLayout
    }
/* start of collectData array
    func collectData(){
        arrData = [
            ModelCollectionFlowLayout(title: "Story Chair", image: #imageLiteral(resourceName: "story chair"), desc:"The perfect story chair in your children's area."),
            ModelCollectionFlowLayout(title: "Image 2", image: #imageLiteral(resourceName: "f7"), desc:"The perfect story chair in your children's area."),
            ModelCollectionFlowLayout(title: "Image 3", image: #imageLiteral(resourceName: "f2"), desc:"The perfect story chair in your children's area."),
            ModelCollectionFlowLayout(title: "Image 4", image: #imageLiteral(resourceName: "f3"), desc:"The perfect story chair in your children's area."),
            ModelCollectionFlowLayout(title: "Image 5", image: #imageLiteral(resourceName: "f1"), desc:"The perfect story chair in your children's area."),
            ModelCollectionFlowLayout(title: "Image 6", image: #imageLiteral(resourceName: "f9"), desc:"The perfect story chair in your children's area."),
            ModelCollectionFlowLayout(title: "Image 7", image: #imageLiteral(resourceName: "f2"), desc:"The perfect story chair in your children's area."),
        ]
    }
    end of collectData arr */
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    fileprivate var currentPage: Int = 0 {
        didSet {
            print("page at centre = \(currentPage)")
        }
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
}
    
extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        //data call from api into labels
        var dict = arrRes[indexPath.row]
        cell.labelTitle?.text = dict["id"] as? String
        cell.labelDesc?.text = dict["title"] as? String
        
        
      /* static data call
        cell.imgView.image = arrData[indexPath.row].image
        cell.labelTitle.text = arrData[indexPath.row].title
        cell.labelDesc.text = arrData[indexPath.row].desc
    */
        return cell
    }
    

}
