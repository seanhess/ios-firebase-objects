#
# Be sure to run `pod spec lint FirebaseObjects.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "FirebaseObjects"
  s.version      = "0.0.2"
  s.summary      = "Higher-level collections and other objects to make Firebase easier."
  s.homepage     = "https://github.com/seanhess/ios-firebase-objects"
  s.license      = 'Simplified BSD License'
  s.author       = { "Sean Clark Hess" => "seanhess+cocoapods@gmail.com" }
  s.source       = { :git => "https://github.com/seanhess/ios-firebase-objects.git", :tag => "0.0.2" }
  s.platform     = :ios, '6.0'
  s.source_files = 'FirebaseObjects/*.{h,m}'
  s.requires_arc = true
  s.dependency 'Firebase', '~> 1.0.0'
end
