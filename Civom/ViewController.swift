//
//  ViewController.swift
//  Civom
//
//  Created by Chitransh on 17/07/19.
//  Copyright © 2019 LateralX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        
        self.HideKeyboard()
        
        //testcode
       
      
    }
}

extension UIViewController {
    func HideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(Tap)
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
}

/* Starts from here commented intentionally 98
 import UIKit
 import SceneKit
 import ARKit
 
 class ViewController: UIViewController, ARSCNViewDelegate {
 
 @IBOutlet var sceneView: ARSCNView!
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 // Set the view's delegate
 sceneView.delegate = self
 
 // Show statistics such as fps and timing information
 sceneView.showsStatistics = true
 
 // Create a new scene
 let scene = SCNScene(named: "art.scnassets/ship.scn")!
 
 // Set the scene to the view
 sceneView.scene = scene
 }
 
 override func viewWillAppear(_ animated: Bool) {
 super.viewWillAppear(animated)
 
 // Create a session configuration
 let configuration = ARWorldTrackingConfiguration()
 
 // Run the view's session
 sceneView.session.run(configuration)
 }
 
 override func viewWillDisappear(_ animated: Bool) {
 super.viewWillDisappear(animated)
 
 // Pause the view's session
 sceneView.session.pause()
 }
 
 // MARK: - ARSCNViewDelegate
 
 /*
 // Override to create and configure nodes for anchors added to the view's session.
 func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
 let node = SCNNode()
 
 return node
 }
 */
 
 func session(_ session: ARSession, didFailWithError error: Error) {
 // Present an error message to the user
 
 }
 
 func sessionWasInterrupted(_ session: ARSession) {
 // Inform the user that the session has been interrupted, for example, by presenting an overlay
 
 }
 
 func sessionInterruptionEnded(_ session: ARSession) {
 // Reset tracking and/or remove existing anchors if consistent tracking is required
 
 }
 }
 
 
 END HERE 98*/