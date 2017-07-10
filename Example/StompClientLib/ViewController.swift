//
//  ViewController.swift
//  StompClientLib
//
//  Created by wrathchaos on 07/07/2017.
//  Copyright (c) 2017 wrathchaos. All rights reserved.
//

import UIKit
import StompClientLib

class ViewController: UIViewController, StompClientLibDelegate {
    
    var socketClient = StompClientLib()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connection with socket
        registerSocket()
    }
    
    func registerSocket(){
        let baseURL = "http://your-url-is-here/"
        // Cut the first 7 character which are "http://" Not necessary!!!
        let wsURL = baseURL.substring(from:baseURL.index(baseURL.startIndex, offsetBy: 7))
        let completedWSURL = "ws://\(wsURL)gateway/websocket"
        print("Completed WS URL : \(completedWSURL)")
        let url = NSURL(string: completedWSURL)!
        
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as URL) , delegate: self as StompClientLibDelegate)
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        let topic = "/topic/your topic is here/"
        print("Socket is Connected : \(topic)")
        socketClient.subscribe(destination: topic)
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected")
    }
    
    func stompClientWillDisconnect(client: StompClientLib!, withError error: NSError) {
        
    }
    
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTIONATION : \(destination)")
        print("JSON BODY : \(String(describing: jsonBody))")
    }
    
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }
    
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error : \(String(describing: message))")
    }
    
    func serverDidSendPing() {
        print("Server Ping")
    }

}

