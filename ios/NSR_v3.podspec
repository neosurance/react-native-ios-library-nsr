Pod::Spec.new do |s|
  s.name             = 'react-native-ios-library-nsr'
  s.version          = '1.0.0'
  s.summary          = 'Collects info from device sensors and from the hosting app'

  s.description      = <<-DESC
Neosurance SDK - Collects info from device sensors and from the hosting app - Exchanges info with the AI engines - Sends the push notification - Displays a landing page - Displays the list of the purchased policies
                       DESC

  s.homepage         = 'https://github.com/neosurance/react-native-ios-library-nsr.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Neosurance' => 'info@neosurance.eu' }
  s.source           = { :git => 'https://github.com/neosurance/react-native-ios-library-nsr.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = './*'
  s.dependency 'AFNetworking'
end
