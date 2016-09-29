//
//  ViewController.swift
//  TWEWatchKit3Example
//
//  Created by Tom Elliott on 9/25/16.
//  Copyright © 2016 Tom Elliott. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {

    var count: Int = 0
    
    var watchSession: WCSession?
    
    @IBOutlet var countLabel: UILabel?
    
    @IBAction func sendMessage(sender: AnyObject) {
        watchSession?.sendMessage(
            ["message":"increment"],
            replyHandler: { (message: [String : Any]) in
            },
            errorHandler: { (err: Error) in
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(WCSession.isSupported()){
            watchSession = WCSession.default()
            watchSession!.delegate = self
            watchSession!.activate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func sessionDidBecomeInactive(_ session: WCSession){}
    
    func sessionDidDeactivate(_ session: WCSession){}
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        count+=1
        updateView()
        replyHandler([:])
    }
    
    func updateView(){
        DispatchQueue.main.async {
            self.countLabel?.text = ("\(self.count)")
        }
    }
}

