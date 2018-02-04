Pod::Spec.new do |s|

  s.name         = "THMarkerView"
  s.version      = "0.0.1"
  s.summary      = "create auto pilot mark in UIScrollView"
  s.description  = "THMarkerView is awesome module, that can make mark in UISrollView. when you tap to mark, UIScrollView zoom to mark center."

  s.homepage     = "https://github.com/TileImageTeamiOS/THMarkerView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Hong Seong Ho" => "grohong76@gmail.com",  'Changnam Hong' => 'hcn1519@gmail.com', 'Han JeeWoong'=>'hjw01234@gmail.com' }

  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/TileImageTeamiOS/THMarkerView.git", :tag =>  s.version.to_s }
  s.source_files  = 'THMarkerView/THMarkerView/*.swift'
  s.frameworks = 'UIKit'

end
