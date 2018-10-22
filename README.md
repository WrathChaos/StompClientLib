# StompClientLib
<p align="center">
<img width="200" height="200" src="https://github.com/WrathChaos/StompClientLib/blob/master/Screenshots/socket.png">
</p>


<p align="center">
<a href="https://github.com/WrathChaos/StompClientLib">
<img src="https://img.shields.io/cocoapods/l/StompClientLib.svg"
alt="License">
</a>
<a href="https://github.com/WrathChaos/StompClientLib">
<img src="https://img.shields.io/cocoapods/p/StompClientLib.svg"
alt="platform">
</a>
<a href="https://github.com/WrathChaos/StompClientLib">
<img src="https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg"
alt="Cocoapods">
</a>
<a href="https://github.com/WrathChaos/StompClientLib">
<img src="https://img.shields.io/cocoapods/dt/StompClientLib.svg"
alt="Downloads">
</a>
</p>



<p align="center">
<a href="https://github.com/WrathChaos/MJPEGStreamLib">
<img src="https://img.shields.io/badge/Swift-4.2-orange.svg"
alt="Swift 4.0">
<img src="https://img.shields.io/badge/Swift-3.0-blue.svg"
alt="Swift 3.0">
</a>
<a href="https://github.com/WrathChaos/StompClientLib">
<img src="https://img.shields.io/cocoapods/v/StompClientLib.svg"
alt="Pod Version">
</a>
<a href="https://github.com/WrathChaos/StompClientLib">
<img src="https://img.shields.io/github/issues/WrathChaos/StompClientLib.svg"
alt="Issues">
</a>
</p>



## Introduction

StompClientLib is a stomp client in Swift. It uses Facebook's [ SocketRocket ](https://github.com/facebook/SocketRocket) as a websocket dependency. SocketRocket is written in Objective-C but StompClientLib's STOMP part is written in Swift and its usage is Swift. You can use this library in your Swift 4+ and 3+ projects.

This is original a fork from [AKStompClient](https://github.com/alibasta/AKStompClient) (This library is not working right now)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 8.0+
- XCode 8.1, 8.2, 8.3
- XCode 9.0+
- **XCode 10.0 +**
- Swift 3.0, 3.1, 3.2
- **Swift 4.0, Swift 4.1, Swift 4.2**


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

# StompClientLibDelegate

## stompClientDidConnect
```ruby
func stompClientDidConnect(client: StompClientLib!) {
print("Socket is connected")
// Stomp subscribe will be here!
socketClient.subscribe(destination: topic)
// Note : topic needs to be a String object
}
```

## stompClientDidDisconnect
```ruby
func stompClientDidDisconnect(client: StompClientLib!) {
print("Socket is Disconnected")
}
```

## stompClientWillDisconnect
```ruby
func stompClientWillDisconnect(client: StompClientLib!, withError error: NSError) {

}
```

## didReceiveMessageWithJSONBody  ( Message Received via STOMP )

Your json message will be converted to JSON Body as AnyObject and you will receive your message in this function
```ruby
func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, withHeader header: [String : String]?, withDestination destination: String) {
print("Destination : \(destination)")
print("JSON Body : \(String(describing: jsonBody))")
}
```

## didReceiveMessageWithJSONBody  ( Message Received via STOMP as String )

Your json message will be converted to JSON Body as AnyObject and you will receive your message in this function
```ruby
func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
print("DESTIONATION : \(destination)")
print("String JSON BODY : \(String(describing: jsonBody))")
}
```


## serverDidSendReceipt 

If you will use STOMP for in-app purchase, you might need to use this function to get receipt 
```ruby
func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
print("Receipt : \(receiptId)")
}
```

## serverDidSendError

Your error message will be received in this function

```ruby
func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
print("Error Send : \(String(describing: message))")
}
```

## serverDidSendPing

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

## Subscribe
```ruby
socketClient.subscribe(destination: topic)
// Note : topic needs to be a String object
```
## Unsubscribe

```ruby
socketClient.unsubscribe(destination: topic)
```

Important : You have to send your destination for both subscribe or unsubscribe!

## Unsubsribe with header

```ruby
let destination = "/topic/your_topic"
let ack = destination 
let id = destination
let header = ["destination": destination, "ack": ack, "id": id]

// subscribe
socketClient?.subscribeWithHeader(destination: destination, withHeader: header)

// unsubscribe
socketClient?.unsubscribe(destination: subsId)
```

## Auto Reconnect with a given time
You can use this feature if you need to auto reconnect with a  spesific time or it will just try to reconnect every second. 

```ruby
// Reconnect after 4 sec
socketClient.reconnect(request: NSURLRequest(url: url as URL) , delegate: self as StompClientLibDelegate, time: 4.0)
```

## Auto Disconnect with a given time

```ruby
// Auto Disconnect after 3 sec
socketClient.autoDisconnect(time: 3)
```


## Future Enhancements

- [x] <del>Complete a working Example<del>
- [ ] Add Carthage installation option
- [ ] Add Swift Package Manager installation option
- [x] <del>XCode 9 compatibility<del>
- [x] <del>Swift 4 compatibility and tests<del>
- [ ] [ Add Quick Testing ](https://github.com/Quick/Quick)
- [ ] Re-write websocket full swift version instead of Facebook's SocketRocket lib

# Change Log

> 
> ## [1.2.5](https://github.com/wrathchaos/StompClientLib/tree/1.2.5) (2018-10-22)
> [ Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/1.2.4...1.2.5)
> 
> **Closed issues:**
> 
> - Value for "message-id" is always "1" [\#22](https://github.com/WrathChaos/StompClientLib/issues/22)
> - Multiple subscription to topics [\#20](https://github.com/WrathChaos/StompClientLib/issues/20)
> - I think there is a memory leak for the delegate [\#19](https://github.com/WrathChaos/StompClientLib/issues/19)
> - Getting error when framwork is installed in Objective c project [\#9](https://github.com/WrathChaos/StompClientLib/issues/9)
> 
> 
>  ## [1.2.4](https://github.com/wrathchaos/StompClientLib/tree/1.2.4) (2018-10-17)
> [Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/1.2.3...1.2.4)
> 
> **Closed issues:**
> 
> - didCloseWithCode 1000, reason: nil [\#21](https://github.com/WrathChaos/StompClientLib/issues/21)
> 
> ## [1.2.3](https://github.com/wrathchaos/StompClientLib/tree/1.2.3) (2018-10-17)
> [Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/1.2.2...1.2.3)
> 
> **Implemented enhancements:**
> 
> - How to receive heartbeat? [\#18](https://github.com/WrathChaos/StompClientLib/issues/18)
> 
> **Closed issues:**
> 
> - Socket is not getting connected [\#30](https://github.com/WrathChaos/StompClientLib/issues/30)
> - didCloseWithCode 1002 [\#29](https://github.com/WrathChaos/StompClientLib/issues/29)
> - No response [\#27](https://github.com/WrathChaos/StompClientLib/issues/27)
> - didCloseWithCode 1001, reason: "Stream end encountered" [\#26](https://github.com/WrathChaos/StompClientLib/issues/26)
> - Stream end encountered [\#17](https://github.com/WrathChaos/StompClientLib/issues/17)
> - unsubscribe socketclient [\#14](https://github.com/WrathChaos/StompClientLib/issues/14)
> - It not able to connect web socket. [\#13](https://github.com/WrathChaos/StompClientLib/issues/13)
> - One of the delegate method is not being called. [\#12](https://github.com/WrathChaos/StompClientLib/issues/12)
> - StompClient Disconnection. [\#10](https://github.com/WrathChaos/StompClientLib/issues/10)
> - Unable to find a specification for 'StompClientLib' [\#8](https://github.com/WrathChaos/StompClientLib/issues/8)
> 
> ## [1.2.2](https://github.com/wrathchaos/StompClientLib/tree/1.2.2) (2017-11-03)
> [Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/1.2.1...1.2.2)
> 
> ## [1.2.1](https://github.com/wrathchaos/StompClientLib/tree/1.2.1) (2017-10-31)
> [Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/1.2.0...1.2.1)
> 
> ## [1.2.0](https://github.com/wrathchaos/StompClientLib/tree/1.2.0) (2017-10-29)
> [Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/1.1.7...1.2.0)
> 
> **Closed issues:**
> 
> - Let client decide what to do with stomp frame body [\#4](https://github.com/WrathChaos/StompClientLib/issues/4)
> - Send message support [\#3](https://github.com/WrathChaos/StompClientLib/issues/3)
> - Error when calling delegate [\#1](https://github.com/WrathChaos/StompClientLib/issues/1)
> 
> ## [1.1.7](https://github.com/wrathchaos/StompClientLib/tree/1.1.7) (2017-10-02)
> [Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/1.1.6...1.1.7)
> 
> ## [1.1.6](https://github.com/wrathchaos/StompClientLib/tree/1.1.6) (2017-08-08)
> [Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/0.1.5...1.1.6)
> 
> ## [0.1.5](https://github.com/wrathchaos/StompClientLib/tree/0.1.5) (2017-07-10)
> [Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/0.1.4...0.1.5)
> 
> ## [0.1.4](https://github.com/wrathchaos/StompClientLib/tree/0.1.4) (2017-07-10)
> [Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/0.1.3...0.1.4)
> 
> ## [0.1.3](https://github.com/wrathchaos/StompClientLib/tree/0.1.3) (2017-07-10)
> [Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/0.1.2...0.1.3)
> 
> ## [0.1.2](https://github.com/wrathchaos/StompClientLib/tree/0.1.2) (2017-07-08)
> [Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/0.1.1...0.1.2)
> 
> ## [0.1.1](https://github.com/wrathchaos/StompClientLib/tree/0.1.1) (2017-07-08)
> [Full Changelog](https://github.com/wrathchaos/StompClientLib/compare/0.1.0...0.1.1)
> 
> ## [0.1.0](https://github.com/wrathchaos/StompClientLib/tree/0.1.0) (2017-07-08)

**[CHANGELOG.md](https://github.com/WrathChaos/StompClientLib/blob/master/CHANGELOG.md)**


## Author

FreakyCoder, kurayogun@gmail.com

## License

StompClientLib is available under the MIT license. See the LICENSE file for more info.
