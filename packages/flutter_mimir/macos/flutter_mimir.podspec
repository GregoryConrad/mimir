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
  spec.preserve_paths = 'EmbeddedMilli.xcframework/**/*'
  spec.vendored_frameworks = 'EmbeddedMilli.xcframework'
  spec.xcconfig = { 'OTHER_LDFLAGS' => '-framework EmbeddedMilli' }


  # TODO clean up following
  # Flutter.framework does not contain a i386 slice.
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  spec.swift_version = '5.0'
  spec.source_files = 'Classes/**/*'
  spec.dependency 'FlutterMacOS'
  spec.static_framework = true

end
