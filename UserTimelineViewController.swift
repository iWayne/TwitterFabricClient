//
//  UserTimeLineViewController.swift
//  TwitterFavricClient
//
//  Created by Wei Shan on 1/5/16.
//  Copyright © 2016 Wei Shan. All rights reserved.
//

import UIKit
import TwitterKit
import OAuthSwift

class UserTimelineViewController: UITableViewController {
    
    var logedin = false
    var tweets = [AnyObject]?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !logedin {
            Twitter.sharedInstance().logOut()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if let _ = Twitter.sharedInstance().sessionStore.session() {
            //Show Tweets
            self.showTweets()
        
        } else {
            //Switch to Login Scene
            self.performSegueWithIdentifier("gotoLogin", sender: self)
            print("We got here")
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        if let tiwts = tweets {
            
        } else {
            return
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = tweets?.count {
            return count
        } else {
            return 0
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
    
    func showTweets() {
        //Make a request
        let twitter = Twitter.sharedInstance()
        let client = OAuthSwiftClient(consumerKey: twitter.consumerKey, consumerSecret: twitter.consumerSecret, accessToken: (twitter.sessionStore.session()?.authToken)!, accessTokenSecret: (twitter.sessionStore.session()?.authTokenSecret)!)
        
        //Send Request and get Data
        client.get("https://api.twitter.com/1.1/statuses/home_timeline.json", success: { (data, response) -> Void in
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                self.tweets = TWTRTweet.tweetsWithJSONArray(json as! [TWTRTweet])
                
                //                    let tweetView = TWTRTweetView(tweet: tweets![0] as! TWTRTweet)
                //                    tweetView.center = CGPointMake(self.view.center.x, self.topLayoutGuide.length + tweetView.frame.size.height / 2);
                //                    self.view.addSubview(tweetView)

                
                
            } catch is NSError {
                print("error")
            }
            }) { (error) -> Void in
                NSLog("Fail to get response")
        }
    }
    
}