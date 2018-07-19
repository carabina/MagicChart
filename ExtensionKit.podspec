Pod::Spec.new do |spec|
  spec.name         = "MagicChart"
  spec.version      = "0.1.0"
  spec.authors      = { "4074" => "fourzerosevenfour@gmail.com" }
  spec.homepage     = "https://github.com/4074/MagicChart"
  spec.summary      = "Magic Chart in Swift"
  spec.source       = { :git => "https://github.com/4074/MagicChart.git" }
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.platform     = :ios, '9.0'
  spec.source_files = "MagicChart/*.swift"

  spec.requires_arc = true

  spec.ios.deployment_target = '9.0'
  spec.ios.frameworks = ['UIKit', 'Foundation']
end
