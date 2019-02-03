//
//  ViewController.swift
//  FB Demo
//
//  Created by Nadaf on 17/01/19.
//  Copyright © 2019 Nadaf. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftMessages

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myLoginButton = UIButton.init(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect.init(x: 0, y: 0, width: 180, height: 40)
        myLoginButton.center = view.center;
        myLoginButton.setTitle("Login", for: .normal)
        
        // Handle clicks on the button
      //  myLoginButton.addTarget(self, action: @selector(self.loginButtonClicked) forControlEvents: .TouchUpInside)
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        // Add the button to the view
        view.addSubview(myLoginButton)
        
    }
    @IBAction func tappedOnView(_ sender: Any) {
        
        print("Tapped on view")
    }
    @IBAction func click(_ sender: Any) {
        
        
        print("Clicked")
    }
    //when login button clicked
    @objc func loginButtonClicked() {
      //  let loginManager = FBSDKLoginManager()
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        fbLoginManager.logOut()
                    }
                }
            }
        }    }
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                   // self.dict = result as! [String : AnyObject]
                    print(result!)
                   // print(self.dict)
                }
            })
        }
    }
    
    
    
    
    @IBAction func add(_ sender: Any) {
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        
        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        warning.configureContent(title: "Ooops!!!", body: "No bookings are available for selected date.", iconText: iconText)
        warning.button?.isHidden = true
       // warning.backgroundView.backgroundColor = .red
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        
         SwiftMessages.show(config: warningConfig, view: warning)
        
    }
}

