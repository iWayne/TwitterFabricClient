//
//  UserTimeLineViewController.swift
//  TwitterFavricClient
//
//  Created by Wei Shan on 1/5/16.
//  Copyright © 2016 Wei Shan. All rights reserved.
//

import UIKit
import TwitterKit
import TDOAuth

class UserTimelineViewController: TWTRTimelineViewController {
    
    var logedin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !logedin {
            Twitter.sharedInstance().logOut()
        }
        self.getDate()
    }
    
    override func viewDidAppear(animated: Bool) {
        /*
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
        */
        
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
    
    func getDate() {
        //Make a request
        let twitter = Twitter.sharedInstance()
        let ouathRequest = TDOAuth.URLRequestForPath("",
            GETParameters: nil,
            scheme: "https",
            host: "api.twitter.com/1.1/statuses/home_timeline.json",
            consumerKey: twitter.consumerKey,
            consumerSecret: twitter.consumerSecret,
            accessToken: twitter.session()?.authToken,
            tokenSecret: twitter.session()?.authTokenSecret)
        print(ouathRequest)
        //Send Request
//        let client = TWTRAPIClient()
//        client.sendTwitterRequest(ouathRequest) { (response, data, connectionError) -> Void in
//            if (connectionError == nil) {
//                do{
//                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
//                    let tweets = TWTRTweet.tweetsWithJSONArray(json as! [AnyObject])
//                    let tweetView = TWTRTweetView(tweet: tweets![0] as! TWTRTweet)
//                    tweetView.center = CGPointMake(self.view.center.x, self.topLayoutGuide.length + tweetView.frame.size.height / 2);
//                    self.view.addSubview(tweetView)
//                    self.viewDidLoad()
//                } catch is NSError {
//                    print("error")
//                }
//                
//            }
//            else {
//                print("Error: \(connectionError)")
//            }
//
//        }
    }
    
    /*
    func getData() {
        let client = TWTRAPIClient()
        let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": "5"]
        var clientError : NSError?
        
        let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod("GET", URL: statusesShowEndpoint, parameters: params, error: &clientError)
        
        print(request.allHTTPHeaderFields)
        
        //Send Request
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if (connectionError == nil) {
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

        
    }
*/
    
    
}