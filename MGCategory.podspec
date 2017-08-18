Pod::Spec.new do |s|

  s.name         = "MGCategory"
  s.version      = "0.0.1"
  s.summary      = "The MGCategory Conducive to rapid development." #快速开发的分类
  s.homepage     = "https://github.com/LYM-mg/MGDemo"
  s.license      = { :type => "MIT", :file => 'LICENSE.md' }
  s.author             = { "LYM-mg" => "1292043630@qq.com" }
  # s.platform     = :ios
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/LYM-mg/MGDemo.git", :tag => "#{s.version}" }
  s.source_files  = "MGDemo", "MGDemo/**/MGCategory/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
  s.frameworks = 'UIKit'
  s.dependency 'MBProgressHUD', '~> 1.0.0'

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  

end
