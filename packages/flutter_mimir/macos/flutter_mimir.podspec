Pod::Spec.new do |spec|
  spec.name          = 'flutter_mimir'
  spec.version       = '0.0.1'
  spec.license       = { :file => '../LICENSE' }
  spec.homepage      = 'https://github.com/GregoryConrad/mimir'
  spec.authors       = { 'Gregory Conrad' => 'gregorysconrad@gmail.com' }
  spec.summary       = 'Embedded instance of milli'

  spec.ios.deployment_target = '9.0'
  spec.osx.deployment_target = '10.11'

  spec.source = { :path => '.' }
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }

  spec.static_framework = true

  spec.preserve_paths = 'EmbeddedMilli.xcframework/**/*'
  spec.vendored_frameworks = 'EmbeddedMilli.xcframework'
  spec.xcconfig = { 'OTHER_LDFLAGS' => '-framework EmbeddedMilli' }
end
