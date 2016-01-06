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

        //let twitter = Twitter.sharedInstance()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*
        let client = TWTRAPIClient()
        let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": "5"]
        var clientError : NSError?
        
        let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod("GET", URL: statusesShowEndpoint, parameters: params, error: &clientError)
        //Get auth
        twitter.startWithConsumerKey("cmsUx91ek6lqYW6Pg0lzG2xwk", consumerSecret: "JgZPQlLumGKVKeXi90K232nBapw%3D")
        //let oauthSigning = TWTROAuthSigning(authConfig:twitter.authConfig, authSession:twitter.session())
        //let authHeaders = oauthSigning.OAuthEchoHeadersToVerifyCredentials()
        //let mutalRequest: NSMutableURLRequest =
        
        
        //Send Request
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if (connectionError == nil) {
//                var jsonError : NSError?
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    let tweets = TWTRTweet.tweetsWithJSONArray(json as! [AnyObject])
                    let tweetView = TWTRTweetView(tweet: tweets![0] as! TWTRTweet)
                    tweetView.center = CGPointMake(self.view.center.x, self.topLayoutGuide.length + tweetView.frame.size.height / 2);
                    self.view.addSubview(tweetView)
                    self.viewDidLoad()
                } catch is NSError {
                    print("error")
                }
                
            }
            else {
                print("Error: \(connectionError)")
            }
        }
        
        
        /*
        if Twitter.sharedInstance().session() != nil {
            
            let userID = Twitter.sharedInstance().session()!.userID
            let client = TWTRAPIClient(userID: userID)
            let tweetIDs = ["20", "510908133917487104"]
            
            client.loadTweetsWithIDs(tweetIDs) { (tweets, error) -> Void in
                print(tweets!.count)
                for i in 1...tweets!.count {
                    let unwrappedTweet = tweets![i - 1]
                    let tweetView = TWTRTweetView(tweet: unwrappedTweet as! TWTRTweet)
                    tweetView.center = CGPointMake(self.view.center.x, self.topLayoutGuide.length + tweetView.frame.size.height / 2 + CGFloat(i * 50));
                    self.view.addSubview(tweetView)
                }
                /*
                {
                    NSLog("Tweet load error: %@", error!.localizedDescription);
                }*/

            }
        }
        */
*/

    }
    
    override func viewDidAppear(animated: Bool) {
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                NSLog("Login with UserID: %@", unwrappedSession.userID)
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

