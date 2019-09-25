//
//  FinalViewController.swift
//  hello_AR_world
//
//  Created by Chitransh on 08/09/19.
//  Copyright © 2019 doug. All rights reserved.
//


import UIKit
import SceneKit
import ARKit
import Alamofire
import SwiftyJSON

// Create structure of Array
struct ObjectCollectionFlowLayout {
    var title:String = ""
    var image:UIImage!
    var btn:UIButton!
}

class FinalViewController: UIViewController, ARSCNViewDelegate {
    
    //Creating Outlets
    @IBOutlet var sceneView2: ARSCNView!
    @IBOutlet var setDogvar: UIButton!
    
    
    //Variable HUD
    private var hud :MBProgressHUD!
      
    let vaseNode = SCNNode()
    let cupNode = SCNNode()
    let chairNode = SCNNode()
    let lampNode = SCNNode()
    let dogNode = SCNNode()
    let rectNode = SCNNode()
 //   var commonNode = SCNNode()
    var node = SCNNode()
    
     // MARK: - CollectionView1
    
    @IBOutlet var collectionView: UICollectionView!
    //array for static data
    var arrData = [ObjectCollectionFlowLayout]()
    
    //array for api
    var arrRes = [[String:AnyObject]]() //array of dictionary
     
    override func viewDidLoad() {
        super.viewDidLoad()
     // MARK: - CollectionView2
            
          //  collectData()

        //start for api request
        
        Alamofire.request("http://35.154.220.170/api/assets").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar.arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                   
                }
                
                if self.arrRes.count > 0 {
                    self.collectionView.reloadData()
                }
            }
        }
        //end for api request
        
        
        collectionView.register(UINib.init(nibName: "ARCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
            
            //properties of UPCarouselFlowLayout.swift file to tweak
            let floawLayout = UPCarouselFlowLayout()
            floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 250.0, height: collectionView.frame.size.height)
            floawLayout.scrollDirection = .horizontal
            floawLayout.sideItemScale = 1
            floawLayout.sideItemAlpha = 1.0
            floawLayout.spacingMode = .fixed(spacing: 5.0)
            collectionView.collectionViewLayout = floawLayout
        //Calling Gestures Recognizer function
        registerGestureRecognizers()
        
        // Show HUD
        self.hud = MBProgressHUD.showAdded(to: self.sceneView2, animated: true)
        self.hud.label.text = "Detecting Plane..."
        
        // Set the view's delegate
        sceneView2.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView2.showsStatistics = true
        
        // MARK: - Creating Button Programmatically
        
        let vaseButton = UIButton(frame: CGRect(x: 30, y: 50, width: 200, height: 50))
        vaseButton.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.4, alpha: 0.8)
        vaseButton.setTitle("Comma Ottoman", for: .normal)
        vaseButton.addTarget(self, action: #selector(setVaseNode), for: .touchUpInside)
        
        let cupButton = UIButton(frame: CGRect(x: 30, y: 100, width: 200, height: 50))
        cupButton.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.4, alpha: 0.8)
        cupButton.setTitle("Corner Ottoman", for: .normal)
        cupButton.addTarget(self, action: #selector(setCupNode), for: .touchUpInside)
        
        let chairButton = UIButton(frame: CGRect(x: 30, y: 150, width: 200, height: 50))
        chairButton.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.4, alpha: 0.8)
        chairButton.setTitle("Cresent Ottoman", for: .normal)
        chairButton.addTarget(self, action: #selector(setChairNode), for: .touchUpInside)
        
        let lampButton = UIButton(frame: CGRect(x: 30, y: 200, width: 200, height: 50))
        lampButton.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.4, alpha: 0.8)
        lampButton.setTitle("Cube", for: .normal)
        lampButton.addTarget(self, action: #selector(setLampNode), for: .touchUpInside)
        
        let dogButton = UIButton(frame: CGRect(x: 30, y: 250, width: 200, height: 50))
        dogButton.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.4, alpha: 0.8)
        dogButton.setTitle("Dog", for: .normal)
        dogButton.addTarget(self, action: #selector(setDogNode), for: .touchUpInside)
        
        let rectButton = UIButton(frame: CGRect(x: 30, y: 300, width: 200, height: 50))
        rectButton.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.4, alpha: 0.8)
        rectButton.setTitle("Hexagon", for: .normal)
        rectButton.addTarget(self, action: #selector(setRectNode), for: .touchUpInside)
//        setDogvar.addTarget(self, action: #selector(setDogNode), for: .touchUpInside)
        
        self.view.addSubview(vaseButton)
        self.view.addSubview(cupButton)
        self.view.addSubview(chairButton)
        self.view.addSubview(lampButton)
        self.view.addSubview(dogButton)
        self.view.addSubview(rectButton)
        
       
        
    }
    
    // MARK: - CollectionView3
    
    // start of collectData array
//      func collectData(){
//          arrData = [ ObjectCollectionFlowLayout(title: "Check 1",image: #imageLiteral(resourceName: "4")),
//                      ObjectCollectionFlowLayout(title: "Check 2",image: #imageLiteral(resourceName: "3")),
//                      ObjectCollectionFlowLayout(title: "Check 3",image: #imageLiteral(resourceName: "2")),
//                      ObjectCollectionFlowLayout(title: "Check 4",image: #imageLiteral(resourceName: "1")),        ]
//      }
    //  end of collectData arr */
      
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
          
    // MARK: - Register Gesture Recognizer
    private func registerGestureRecognizers() {
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchRecognized))
        self.view.addGestureRecognizer(pinchGesture)
        
        let rotateGesture = UIPanGestureRecognizer(target: self, action: #selector(rotateRecognized))
        rotateGesture.minimumNumberOfTouches = 2
        rotateGesture.maximumNumberOfTouches = 2
        self.view.addGestureRecognizer(rotateGesture)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let standardConfiguration: ARWorldTrackingConfiguration = {
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = .horizontal
            return configuration
        }()
        
        // Run the view's session
        sceneView2.session.run(standardConfiguration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView2.session.pause()
    }
    
    // MARK: - Adding HUD Function
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if anchor is ARPlaneAnchor {
            
            DispatchQueue.main.async {
                
                self.hud.label.text = "Plane Detected"
                self.hud.hide(animated: true, afterDelay: 1.0)
            }
        }
        
    }
    
    // MARK: - Tap function
    @IBAction func handleTapped(_ sender: UITapGestureRecognizer) {
        /* Looking at the location where the user touched the screen */
        let result = sceneView2.hitTest(sender.location(in: sceneView2), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitResult = result.last else {return}
        
        /* transforms the result into a matrix_float 4x4 so the SCN Node can read the data */
        let hitTransform = hitResult.worldTransform
        
        /* Print the coordinates captured */
        print("x: ", hitTransform[3].x, "\ny: ", hitTransform[3].y, "\nz: ", hitTransform[3].z)
        
        /* Look at Add Geometry Class in Controller Group */
        switch node {
        case vaseNode:
            addObject(position: hitTransform, sceneView: sceneView2, node: vaseNode, objectPath: "art.scnassets/Comma/Comma.scn")
        case cupNode:
            addObject(position: hitTransform, sceneView: sceneView2, node: cupNode, objectPath: "art.scnassets/Corner/Corner.scn")
        case chairNode:
            addObject(position: hitTransform, sceneView: sceneView2, node: chairNode, objectPath: "art.scnassets/Cresent/Cresent.scn")
        case lampNode:
            addObject(position: hitTransform, sceneView: sceneView2, node: lampNode, objectPath: "art.scnassets/Cube/Cube_old.scn")
        case dogNode:
            addObject(position: hitTransform, sceneView: sceneView2, node: dogNode, objectPath: "art.scnassets/dog/dog.scn")
        case rectNode:
        addObject(position: hitTransform, sceneView: sceneView2, node: dogNode, objectPath: "art.scnassets/Rectangle/rectangle_new.dae")
        default:
            print("No Node Found")
        }
    }
    // MARK: - Adding Objects to Scene
    func addObject(position: matrix_float4x4, sceneView: ARSCNView, node: SCNNode, objectPath: String){
        
        node.position = SCNVector3(position[3].x, position[3].y, position[3].z)
        
        // Create a new scene
        guard let virtualObjectScene = SCNScene(named: objectPath)
            else {
                print("Unable to Generate" + objectPath)
                return
        }
        
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        
        node.addChildNode(wrapperNode)
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    // MARK: - Implementing Gestures
    @objc func pinchRecognized(pinch: UIPinchGestureRecognizer) {
     //   node.runAction(SCNAction.scale(by: pinch.scale, duration: 0.5))
    
        if pinch.state == .began || pinch.state == .changed {
            let scale = Float(pinch.scale)
            
            let newscalex = scale * self.node.scale.x
            let newscaley = scale * self.node.scale.y
            let newscalez = scale * self.node.scale.z
            
            self.node.scale = SCNVector3(newscalex, newscaley, newscalez)
            pinch.scale = 1.0
        }
    }
    
    @objc func rotateRecognized(rotate: UIPanGestureRecognizer) {
        
        let xPan = rotate.velocity(in: sceneView2).x/6000
        /*
         y pan is a not tuned for user expereience
         let yPan = pan.velocity(in: sceneView).y/10000
         */
        
        node.runAction(SCNAction.rotateBy(x: 0, y: xPan, z: 0, duration: 0.1))
    }
    /*
    @objc func onTranslate(pan: UIPanGestureRecognizer) {
        let position = pan.location(in: sceneView2)
        let state = pan.state

        if (state == .failed || state == .cancelled) {
            return
        }

        if (state == .began) {
            // Check it's on a virtual object
            if let objectNode =  (at: position) {
                // virtualObject(at searches for root node if it's a subnode
                targetNode = objectNode
                latestTranslatePos = position
            }

        }
        else if let _ = targetNode {

            // Translate virtual object
            let deltaX = Float(position.x - latestTranslatePos!.x)/700
            let deltaY = Float(position.y - latestTranslatePos!.y)/700

            targetNode!.localTranslate(by: SCNVector3Make(deltaX, 0.0, deltaY))

            latestTranslatePos = position

            if (state == .ended) {
                targetNode = nil
            }
        }
    }
 */
  /*
    @objc func panRecognized(_ gesture: UIPanGestureRecognizer) {

        gesture.minimumNumberOfTouches = 1

        let results = self.sceneView2.hitTest(gesture.location(in: gesture.view), types: ARHitTestResult.ResultType.featurePoint)

        guard let result: ARHitTestResult = results.first else {
            return
        }

        let hits = self.sceneView2.hitTest(gesture.location(in: gesture.view), options: nil)
        if let tappedNode = hits.first?.node {
            let position = SCNVector3Make(result.worldTransform.columns.3.x, result.worldTransform.columns.3.y, result.worldTransform.columns.3.z)
            tappedNode.position = position
        }

    }*/
    // MARK: - Function setting node var
    @objc func setVaseNode(sender: UIButton!) {
        node = vaseNode
    }
    
    @objc func setCupNode(sender: UIButton!) {
        node = cupNode
    }
    
    @objc func setChairNode(sender: UIButton!) {
        node = chairNode
    }
    
    @objc func setLampNode(sender: UIButton!) {
        node = lampNode
    }
    
    @objc func setDogNode(sender: UIButton!) {
        node = dogNode
    }
    
    @objc func setRectNode(sender: UIButton!) {
           node = rectNode
       }
    
}

//MARK:- CollectionView4
extension FinalViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ARCollectionViewCell
   
  /*    static data call
        cell.ObjThumbnail.image = arrData[indexPath.row].image
        cell.labelTitle.text = arrData[indexPath.row].title
  */
        
        //data call from api into labels
        let dict = arrRes[indexPath.row]
       cell.ObjTitle?.text = dict["name"] as? String
       // cell.labelDesc?.text = dict["description"] as? String
        
        return cell
    }
}
