//
//  InterfaceController.swift
//  TWEWatchKit3Example WatchKit Extension
//
//  Created by Tom Elliott on 9/25/16.
//  Copyright © 2016 Tom Elliott. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    var count: Int = 0
    
    @IBOutlet var countLabel: WKInterfaceLabel?
    
    @IBAction func sendMessage(sender: AnyObject) {
        watchSession?.sendMessage(
            ["message":"increment"],
            replyHandler: { (message: [String : Any]) in
            },
            errorHandler: { (err: Error) in
        })
    }

    
    var watchSession : WCSession?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if(WCSession.isSupported()){
            watchSession = WCSession.default()
            // Add self as a delegate of the session so we can handle messages
            watchSession!.delegate = self
            watchSession!.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        NSLog("Watch session activated")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        count+=1
        updateView()
        replyHandler([:])
    }
    
    func updateView(){
        countLabel?.setText("\(self.count)")
    }
}
