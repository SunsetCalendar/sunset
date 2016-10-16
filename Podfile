# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

plugin 'cocoapods-keys', {
  :project => 'sunset',
  :keys => [
    'APIKey',
    'BUILDSECRET',
    'consumerKey',
    'consumerSecret'
  ]
}

target 'sunset' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Fabric'
  pod 'TwitterKit'

  # Pods for sunset

  target 'sunsetTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'sunsetUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
