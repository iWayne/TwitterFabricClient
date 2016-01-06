//
//  UserTimeLineViewController.swift
//  TwitterFavricClient
//
//  Created by Wei Shan on 1/5/16.
//  Copyright © 2016 Wei Shan. All rights reserved.
//

import UIKit
import TwitterKit

class UserTimelineViewController: TWTRTimelineViewController {
    
    var logedin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !logedin {
            Twitter.sharedInstance().logOut()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if let session = Twitter.sharedInstance().sessionStore.session() {
            //Show Tweets
            let userID = session.userID
            let client = TWTRAPIClient(userID: userID)
            self.dataSource = TWTRListTimelineDataSource(listSlug: "twitter-syndication-team", listOwnerScreenName: "benward", APIClient: client)
            self.showTweetActions = true
        } else {
            //Switch to Login Scene
            self.performSegueWithIdentifier("gotoLogin", sender: self)
            print("We got here")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gotoLogin" {
            segue.destinationViewController as! LoginViewController
        }
    }
    
    
    
}