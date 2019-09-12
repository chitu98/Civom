//
//  ContactVC.swift
//  Civom
//
//  Created by Chitransh on 08/08/19.
//  Copyright © 2019 LateralX. All rights reserved.
//

import UIKit
import MessageUI

class ContactVC: UIViewController, MFMailComposeViewControllerDelegate {

    // Button for call function
    
    @IBAction func callBtn(_ sender: UIButton) {
        makePhoneCall(phoneNumber: "9876643210")
    }
    
    // To Call
    @IBAction func sendMail(_ sender: Any) {
        sendMailfunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

    }

// Function to make calls
    
    func makePhoneCall(phoneNumber: String) {
        
        if let phoneURL = NSURL(string: ("tel://" + phoneNumber)) {
            
            let alert = UIAlertController(title: ("Call " + phoneNumber + "?"), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (action) in
                UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

// Function to send mail
    
    func sendMailfunc(){
        let mailCompose = MFMailComposeViewController()
        mailCompose.mailComposeDelegate = self
        mailCompose.setToRecipients(["support@civom.co.in"])
        mailCompose.setSubject("Hello")
        mailCompose.setMessageBody("This is a test email from Civom iOS App :D", isHTML: false)
        
        if MFMailComposeViewController.canSendMail(){
            self.present(mailCompose, animated: true, completion: nil)
        }else{
            print("Nada!")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
