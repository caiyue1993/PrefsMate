#
# Be sure to run `pod lib lint PrefsMate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PrefsMate'
  s.version          = '0.1.0'
  s.summary          = 'A short description of PrefsMate.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/caiyue1993/PrefsMate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'caiyue1993' => 'yuecai.nju@gmail.com' }
  s.source           = { :git => 'https://github.com/caiyue1993/PrefsMate.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/caiyue5'

  s.ios.deployment_target = '9.0'
  
  s.source_files = 'Source/*.swift'
  s.frameworks = 'UIKit'

end
