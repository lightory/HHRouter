Pod::Spec.new do |s|
  s.name         = "HHRouter"
  s.version      = "0.0.1"
  s.summary      = "HHRouter, yet another URL Router for iOS."
  s.homepage     = "https://github.com/Huohua/HHRouter/"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Light" => "lightory@gmail.com" }
  s.platform     = :ios, '5.0'
  s.source       = { :git => "https://github.com/Huohua/HHRouter/", :commit => '88944c659c31f38d3947bc3e261f7cb201c43343' }
  s.source_files  = 'HHRouter.h,m' 
  s.requires_arc = true
end
