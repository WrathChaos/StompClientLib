# StompClientLib

[![CI Status](http://img.shields.io/travis/wrathchaos/StompClientLib.svg?style=flat)](https://travis-ci.org/wrathchaos/StompClientLib)
[![Version](https://img.shields.io/cocoapods/v/StompClientLib.svg?style=flat)](http://cocoapods.org/pods/StompClientLib)
[![License](https://img.shields.io/cocoapods/l/StompClientLib.svg?style=flat)](http://cocoapods.org/pods/StompClientLib)
[![Platform](https://img.shields.io/cocoapods/p/StompClientLib.svg?style=flat)](http://cocoapods.org/pods/StompClientLib)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

StompClientLib is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "StompClientLib"
```

## Usage
```ruby
import StompClientLib
```

Once imported, you can open a connection to your WebSocket server. 

```ruby
var socketClient = StompClientLib()
let url = NSURL(string: "your-socket-url-is-here")!
socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as URL) , delegate: self)
```

After you are connected, there are some delegate methods that you need to implement.

## StompClientLibDelegate

# stompClientDidConnect
```ruby
func stompClientDidConnect(client: StompClientLib!) {
    print("Socket is connected")
    // Stomp subscribe will be here!
    socketClient.subscribe(destination: topic)
    // Note : topic needs to be a String object
}
```

# stompClientDidDisconnect
```ruby
func stompClientDidDisconnect(client: StompClientLib!) {
    print("Socket is Disconnected")
}
```


# stompClientWillDisconnect
```ruby
func stompClientWillDisconnect(client: StompClientLib!, withError error: NSError) {

}
```

# didReceiveMessageWithJSONBody  ( Message Received via STOMP )

Your json message will be converted to JSON Body as AnyObject and you will receive your message in this function
```ruby
func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, withHeader header: [String : String]?, withDestination destination: String) {
    print("Destination : \(destination)")
    print("JSON Body : \(String(describing: jsonBody))")
}
```

# serverDidSendReceipt 

If you will use STOMP for in-app purchase, you might need to use this function to get receipt 
```ruby
func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
    print("Receipt : \(receiptId)")
}
```

#serverDidSendError

Your error message will be received in this function

```ruby
func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
    print("Error Send : \(String(describing: message))")
}
```

# serverDidSendPing

If you need to control your server's ping, here is your part 

```ruby
func serverDidSendPing() {
    print("Server ping")
}
```


## How to subscribe and unsubscribe

There are functions for subscribing and unsubscribing. 
Note : You should handle your subscribe and unsubscibe methods ! 
Suggestion : Subscribe to your topic in "stompClientDidConnect" function and unsubcribe to your topic in stompClientWillDisconnect method. 

# Subscribe
```ruby
socketClient.subscribe(destination: topic)
// Note : topic needs to be a String object
```
# Unsubscribe

```ruby
socketClient.unsubscribe(destination: topic)
```

Important : You have to send your destination for both subscribe or unsubscribe!

## Author

FreakyCoder, kurayogun@gmail.com

## License

StompClientLib is available under the MIT license. See the LICENSE file for more info.
