//
//  ViewController.swift
//  StompClientLibExample
//
//  Created by Kuray on 8.10.2020.
//

import UIKit
import StompClientLib

class ViewController: UIViewController, StompClientLibDelegate {
    
    @IBOutlet weak var connectionLabel: UILabel!
    
    var socketClient = StompClientLib()
    let topic = "/topic/greetings"
    var url = NSURL()
    @IBOutlet weak var socketButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var autoConnectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Connection with socket
        registerSocket()
        
        
        socketButton.layer.cornerRadius = 12
        socketButton.layer.borderWidth = 1
        socketButton.layer.backgroundColor = UIColor.blue.cgColor
        socketButton.layer.borderColor = UIColor.blue.cgColor
        
        disconnectButton.layer.cornerRadius = 12
        disconnectButton.layer.borderWidth = 1
        disconnectButton.layer.backgroundColor = UIColor.red.cgColor
        disconnectButton.layer.borderColor = UIColor.red.cgColor
        
        sendMessageButton.layer.cornerRadius = 12
        sendMessageButton.layer.borderWidth = 1
        sendMessageButton.layer.backgroundColor = UIColor.brown.cgColor
        sendMessageButton.layer.borderColor = UIColor.brown.cgColor
        
        autoConnectionButton.layer.cornerRadius = 12
        autoConnectionButton.layer.borderWidth = 1
        autoConnectionButton.layer.backgroundColor = UIColor.systemYellow.cgColor
        autoConnectionButton.layer.borderColor = UIColor.systemYellow.cgColor
        
    }
    
    @IBAction func btnPressed(_ sender: Any) {
        registerSocket()
    }
    
    @IBAction func disconnectBtnPressed(_ sender: Any) {
        socketClient.disconnect()
    }
    
    @IBAction func sendMessageBtnPressed(_ sender: Any) {
        socketClient.sendMessage(message: "StompClientLib Foo", toDestination: "/app/hello", withHeaders: nil, withReceipt: nil)
    }
    
    @IBAction func autoBtnPressed(_ sender: Any) {
        // Auto Disconnect after 3 sec
        socketClient.autoDisconnect(time: 3)
        // Reconnect after 4 sec
        socketClient.reconnect(request: NSURLRequest(url: url as URL) , delegate: self as StompClientLibDelegate, time: 4.0)
 
    }
    
    
    func registerSocket(){
        let baseURL = "http://localhost:8080/"
        // Cut the first 7 character which are "http://" Not necessary!!!
        // substring is depracated in iOS 11, use prefix instead :)
        let wsURL = baseURL.substring(from:baseURL.index(baseURL.startIndex, offsetBy: 7))
        let completedWSURL = "ws://\(wsURL)hello/websocket"
        
        
        url = NSURL(string: completedWSURL)!
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as URL) , delegate: self as StompClientLibDelegate)
    }
    
    func stompClientDidConnect(client: StompClientLib!, withHeader: [String : Any]?) {
        let topic = self.topic
        print("Socket is Connected : \(topic)")
        socketClient.subscribe(destination: topic)
        connectionLabel.text = "Socket is connected successfully!"
        connectionLabel.textColor = UIColor.systemGreen
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected")
        connectionLabel.text = "Socket is disconnected"
        connectionLabel.textColor = UIColor.purple
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTIONATION : \(destination)")
        print("JSON BODY : \(String(describing: jsonBody))")
        print("STRING BODY : \(stringBody ?? "nil")")
    }
    
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTIONATION : \(destination)")
        print("String JSON BODY : \(String(describing: jsonBody))")
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error : \(String(describing: message))")
        connectionLabel.text = "Failed to Connect!"
        connectionLabel.textColor = UIColor.red
    }
    
    func serverDidSendPing() {
        print("Server Ping")
    }
    
}
