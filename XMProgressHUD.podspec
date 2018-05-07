#
#  Be sure to run `pod spec lint XMProgressHUD.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "XMProgressHUD"
  s.version      = "1.0.0"
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = '7.0'
  s.summary      = "A Simple prompt box."
  s.homepage     = "https://github.com/xmalt/XMProgressHUD-master.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "高昇" => "xiaogao233@163.com" }
  s.source       = { :git => "https://github.com/xmalt/XMProgressHUD-master.git", :tag => "#{s.version}" }
  s.source_files  = "XMProgressHUD/*.{h,m}","XMProgressHUD/*/*.{h,m}"
  s.resources     = "XMProgressHUD/resource.bundle" #资源图片
  s.requires_arc = true
  s.dependency "MBProgressHUD", "~> 1.1.0"
end
