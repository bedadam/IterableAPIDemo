//
//  ViewController.swift
//  Iterable Demo
//
//  Created by sridhar bedadam on 2/21/21.
//

import UIKit
import IterableSDK

class ViewController: UIViewController {
    var window: UIWindow?

    @IBOutlet weak var iterableLogo: UIImageView!
    @IBOutlet weak var iterableLabel: UILabel!
    @IBOutlet weak var accountEmail: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var logEvent: UIButton!
    var radius = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        accountEmail.layer.cornerRadius = CGFloat(radius)
        updateButton.layer.cornerRadius  = CGFloat(radius)
        logEvent.layer.cornerRadius = CGFloat(radius)
    }
    
    @IBAction func didTapButton(sender: UIButton){
        // update the email
        //IterableAPI.email = "sridhar.bedadam@gmail.com"
        IterableAPI.email = accountEmail.text
        
        if(sender == updateButton){
            // update user profile
            if accountEmail.text == "" {
             print("No email address")
             let alert = UIAlertController(title: "Email", message: "Please enter a valid email address.", preferredStyle: .alert)

             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

             self.present(alert, animated: true)
            }else{
             IterableAPI.email = accountEmail.text
             // Example data fields
                 let dataField : [String: Any] = [
                     "firstName1":"Sridhar",
                     "isRegisteredUser":"true",
                     "SA_User_Test_Key": "completed"
                 ]
             
             IterableAPI.updateUser(dataField, mergeNestedObjects: false, onSuccess: myUserUpdateSuccessHandler, onFailure: myUserUpdateFailureHandler)
            }
        }else if(sender == logEvent){
            // log custom event
            let customEventData : [String: Any] = [
                "platform":"iOS",
                "isTestEvent":"true",
                "url": "https://iterable.com/sa-test/YOUR_FIRST_NAME_HERE",
                "secret_code_key":"Code_123"
            ]
            
            IterableAPI.track(event: "mobileSATestEvent", dataFields:customEventData)
        }
    }
    
    func myUserUpdateSuccessHandler(data:[AnyHashable:Any]?) -> () {
        // success
        print("sent to Iterable success")
    }

    func myUserUpdateFailureHandler(reason:String?, data:Data?) -> () {
        // failure
        print("sent to Iterable failure")
    }


}

