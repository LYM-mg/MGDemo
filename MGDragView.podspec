

Pod::Spec.new do |s|

  s.name         = "MGDragView"
  s.version      = "0.0.2"
  s.summary      = "A short description of MGDragView. 可拖拽的View"
  s.homepage     = "http://github.com/LYM-mg/MGDemo"
  s.license      = "MIT (example)"
  s.homepage     = "https://github.com/LYM-mg/MGDemo"
  s.license      = { :type => "MIT", :file => 'LICENSE.md' }
  s.author             = { "LYM-mg" => "1292043630@qq.com" }
  # s.platform     = :ios
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/LYM-mg/MGDemo", :tag => "#{s.version}" }

  s.source_files  = "MGDragView/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
  s.frameworks = 'UIKit'

end
