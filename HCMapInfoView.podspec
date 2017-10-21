Pod::Spec.new do |s|

s.platform = :ios
s.name             = "HCMapInfoView"
s.version          = "1.0.0"
s.summary          = "HCMapInfoView is an iOS library for creating custom info views for Apple maps."

s.description      = <<-DESC
HCMapInfoView is an iOS library which facilitates creating custom info views for Apple maps.
DESC

s.homepage         = "https://github.com/Hypercubesoft/HCMapInfoView"
s.license          = { :type => "MIT", :file => "LICENSE" }
s.author           = { "Hypercubesoft" => "office@hypercubesoft.com" }
s.source           = { :git => "https://github.com/Hypercubesoft/HCMapInfoView.git", :tag => "#{s.version}"}

s.ios.deployment_target = "9.0"
s.source_files = "Source/HCMapInfoView", "Source/HCMapInfoView/**/*"

s.dependency 'HCFramework'

end
