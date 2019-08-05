#
# Be sure to run `pod lib lint StompClientLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DTStompClientLib'
  s.version          = '1.3.5'
  s.summary          = 'Simple STOMP Client library. Swift 3, 4, 4.2, 5 compatible'
  s.swift_version = '4.0', '4.2', '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Simple STOMP Client library, Swift 3, 4, 4.2, 5 compatible. STOMP Protocol let the program subscribe or unsubscribe the topic. It connects the websocket and use the STOMP protocol to subscribe the topic and recieve the message, receipt or even a ping.
                       DESC

  s.homepage         = 'https://github.com/rodmytro/StompClientLib'
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'FreakyCoder' => 'kurayogun@gmail.com' }
  s.source           = { :git => 'https://github.com/rodmytro/StompClientLib.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/freakycodercom'

  s.ios.deployment_target = '9.0'

  s.source_files = 'StompClientLib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'StompClientLib' => ['StompClientLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SocketRocket'
end
