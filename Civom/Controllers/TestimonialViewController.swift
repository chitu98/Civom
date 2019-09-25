//
//  TestimonialViewController.swift
//  Civom
//
//  Created by Chitransh on 21/09/19.
//  Copyright © 2019 LateralX. All rights reserved.
//

import UIKit
import AVKit

class TestimonialViewController: UIViewController {

    @IBAction func playBtn(_ sender: Any) {
        
        if let path = Bundle.main.path(forResource: "Testimonial_Handbrake", ofType: "mp4")
        {
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion: {
                video.play()
            })
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

   

}
