//
//  ViewController.swift
//  TwitterFavricClient
//
//  Created by Wei Shan on 1/4/16.
//  Copyright © 2016 Wei Shan. All rights reserved.
//

import UIKit
import TwitterKit


class LoginViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                NSLog("Login with UserID: %@", unwrappedSession.userID)
                NSLog("The token is %@", unwrappedSession.authToken)
                self.performSegueWithIdentifier("gotoTimeline", sender: self)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
        
        if let _ = Twitter.sharedInstance().session() {
            self.performSegueWithIdentifier("gotoTimeline", sender: self)
        } else {
            NSLog("Needed Login")
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gotoTimeline" {
            (segue.destinationViewController as! UserTimelineViewController).logedin = true
        }
    }

}

