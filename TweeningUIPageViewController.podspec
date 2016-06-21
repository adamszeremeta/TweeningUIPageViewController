Pod::Spec.new do |s|

  s.name         = 'TweeningUIPageViewController'
  s.version      = '1.0.0'
  s.summary      = 'Extended UIPageViewController with background color tweening'

  s.homepage     = 'https://github.com/adamszeremeta/TweeningUIPageViewController'

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { 'Adam Szeremeta' => 'adamszeremeta@gmail.com' }

  s.source       = { :git => 'https://github.com/adamszeremeta/TweeningUIPageViewController.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'TweeningUIPageViewController/*.swift'

end