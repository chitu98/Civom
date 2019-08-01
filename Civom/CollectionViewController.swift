//
//  CollectionViewController.swift
//  Civom
//
//  Created by Chitransh on 25/07/19.
//  Copyright © 2019 LateralX. All rights reserved.
//

import UIKit

struct ModelCollectionFlowLayout {
    var title:String = ""
    var image:UIImage!
    var desc:String = ""
}
class CollectionViewController: UIViewController {
   
    
    var arrData = [ModelCollectionFlowLayout]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectData()
        
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
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.imgView.image = arrData[indexPath.row].image
        cell.labelTitle.text = arrData[indexPath.row].title
        cell.labelDesc.text = arrData[indexPath.row].desc
        return cell
    }
    
    
    
    
    
}


