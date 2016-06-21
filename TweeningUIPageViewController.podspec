Pod::Spec.new do |s|

  s.name         = "TweeningUIPageViewController"
  s.version      = "1.0.0"
  s.summary      = "Extended UIPageViewController with background color tweening"

  s.homepage     = "https://github.com/adamszeremeta/TweeningUIPageViewController"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = "Adam Szeremeta"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/Rst-It/ios-swift-utils.git", :tag => s.version.to_s }
  s.source_files = "TweeningUIPageViewController/*.swift"
  s.module_name  = "TweeningUIPageViewController"
  s.requires_arc = true

end