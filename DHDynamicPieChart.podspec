#
#  Be sure to run `pod spec lint DHPieChart.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "DHDynamicPieChart"
  s.version      = "1.0.0"
  s.summary      = "Highly customised level pie chart."
  s.homepage     = "https://github.com/DavidHSW/DHDynamicPieChart"
  s.author       = { "David Hu" => "david.mr.who@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/DavidHSW/DHDynamicPieChart.git", :tag => "1.0.0" }
  s.source_files  = "DHDynamicPieChart", "DHPieChart/**/*.{h,m}"
  s.framework    = "UIKit"
  s.license      = "MIT"

end
