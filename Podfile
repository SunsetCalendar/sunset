# Uncomment this line to define a global platform for your project
# platform :ios, '10.0'

plugin 'cocoapods-keys', {
  :project => 'sunset',
  :keys => [
    'APIKEY',
    'BUILDSECRET',
    'consumerKey',
    'consumerSecret'
  ]
}

target 'sunset' do
  
  # for sunset
  use_frameworks!
  pod 'Fabric'
  pod 'TwitterKit'

  target 'sunsetTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'sunsetUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
