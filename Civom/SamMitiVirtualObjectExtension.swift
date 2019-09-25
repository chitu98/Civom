//
//  VirtualObject.swift
//  SamMiti-Example
//
//  Created by Nattawut Singhchai on 9/2/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import SamMitiAR
import GLTFSceneKit
import ARKit
import Alamofire

extension SamMitiVirtualObject {
    
    // Teapot model
    static var metalTeapotOldMetal: SamMitiVirtualObject {
        let refNode = SCNReferenceNode(named: "art.scnassets/Trihex/trihex.scn")!
        let virtualNode = SamMitiVirtualObject(refferenceNode: refNode, allowedAlignments: .all)
        virtualNode.name = "Metal Teapot—Old Metal"
        
        virtualNode.setAnimationForVirtualObjectRemoving { (node, completed) in
            SceneKitAnimator.animateWithDuration(duration: 0.35 / 2, timingFunction: .easeIn, animations: {
                let transform = SCNMatrix4MakeScale(0.01, 0.01, 0.01)
                node.contentNode?.transform = transform
            }, completion: completed)
        }
        return virtualNode
    }
    
    // Teapot model
    static var metalTeapotRusty: SamMitiVirtualObject {
        let refNode = SCNReferenceNode(named: "art.scnassets/Sombrero/sombrero.scn")!
        let virtualNode = SamMitiVirtualObject(refferenceNode: refNode, allowedAlignments: .all)
        virtualNode.name = "Metal Teapot—Hammerite"
        
        virtualNode.setAnimationForVirtualObjectRemoving { (node, completed) in
            SceneKitAnimator.animateWithDuration(duration: 0.35 / 2, timingFunction: .easeIn, animations: {
                let transform = SCNMatrix4MakeScale(0.01, 0.01, 0.01)
                node.contentNode?.transform = transform
            }, completion: completed)
        }
        return virtualNode
    }
    
    // Teapot model
    static var metalTeapotGold: SamMitiVirtualObject {
        let refNode = SCNReferenceNode(named: "art.scnassets/tube/tube.scn")!
        let virtualNode = SamMitiVirtualObject(refferenceNode: refNode, allowedAlignments: .all)
        virtualNode.name = "Metal Teapot—Gold"
        
        virtualNode.setAnimationForVirtualObjectRemoving { (node, completed) in
            SceneKitAnimator.animateWithDuration(duration: 0.35 / 2, timingFunction: .easeIn, animations: {
                let transform = SCNMatrix4MakeScale(0.01, 0.01, 0.01)
                node.contentNode?.transform = transform
            }, completion: completed)
        }
        return virtualNode
    }
    
    // Cube model
    static var Cube: SamMitiVirtualObject {
        
        var objectURL : URL!
        var passNode : SCNReferenceNode!
        var pathURL :URL!
        
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
//
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
        objectURL = URL(fileURLWithPath: dirPath).appendingPathComponent("testnew.scn")
            
            // for AR
            

            print("ye object url h ",objectURL!)
            
        }
            
        print("2nd time printing ",passNode)

        let urlString = URL(string: "https://tmpfiles.org/download/26563/testnew.scn")
        let urlTexture = URL(string: "https://tmpfiles.org/download/26567/Maptest.jpg")
//                Alamofire.download(urlString!, to: destination).response { response in // method defaults to `.get`
//                    print(response.request)
//                    print(response.response)
//            print(response.temporaryURL)
//            print(response.destinationURL)
//            print(response.error)
//
//        }

        Alamofire.download(
            urlString!,
        method: .get,
        parameters: nil,
        encoding: JSONEncoding.default,
        headers: nil,
        to: destination).downloadProgress(closure: { (progress) in
            print(progress)
        }).response(completionHandler: { (DefaultDownloadResponse) in
//            let path = DefaultDownloadResponse.destinationURL
//            let node = SCNReferenceNode(url: path!)
//            node?.load()
//            print("ye h path :", path)
//            print(node)
//            pathURL = path
//            print("ye h path url " , pathURL as Any)
         //   print(node?.geometry)
            //self.sceneView.scene.rootNode.addChildNode(node!)
        })
        
        
         Alamofire.download(
                    urlTexture!,
                method: .get,
                parameters: nil,
                encoding: JSONEncoding.default,
                headers: nil,
                to: destination).downloadProgress(closure: { (progress) in
                    print(progress)
                }).response(completionHandler: { (DefaultDownloadResponse) in
        //            let path = DefaultDownloadResponse.destinationURL
        //            let node = SCNReferenceNode(url: path!)
        //            node?.load()
        //            print("ye h path :", path)
        //            print(node)
        //            pathURL = path
        //            print("ye h path url " , pathURL as Any)
                 //   print(node?.geometry)
                    //self.sceneView.scene.rootNode.addChildNode(node!)
                })
        
////
        let refNode = SCNReferenceNode(url: objectURL)!
        refNode.load()
//        let virtualNode = SamMitiVirtualObject(refferenceNode: passNode, allowedAlignments: .all)
        let virtualNode = SamMitiVirtualObject(containNode: refNode, allowedAlignments: .all)
        virtualNode.name = "Cube"
        
        virtualNode.setAnimationForVirtualObjectRemoving { (node, completed) in
            SceneKitAnimator.animateWithDuration(duration: 0.35 / 2, timingFunction: .easeIn, animations: {
                let transform = SCNMatrix4MakeScale(0.01, 0.01, 0.01)
                node.contentNode?.transform = transform
            }, completion: completed)
        }
        return virtualNode
    }
    
    
}
