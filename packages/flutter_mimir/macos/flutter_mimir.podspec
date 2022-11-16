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
  spec.static_framework = true
  spec.vendored_libraries = "**/*.a"

  spec.pod_target_xcconfig = {
    'ENABLE_BITCODE' => 'NO',
    'DEFINES_MODULE' => 'YES',
    'OTHER_LDFLAGS' => '-lembedded_milli',
    'LIBRARY_SEARCH_PATHS[sdk=iphoneos*][arch=arm64]' => '${PODS_TARGET_SRCROOT}/target/aarch64-apple-ios',
    'LIBRARY_SEARCH_PATHS[sdk=iphonesimulator*][arch=x86_64]' => '${PODS_TARGET_SRCROOT}/target/x86_64-apple-ios',
    'LIBRARY_SEARCH_PATHS[sdk=iphonesimulator*][arch=arm64]' => '${PODS_TARGET_SRCROOT}/target/aarch64-apple-ios-sim',
    'LIBRARY_SEARCH_PATHS[sdk=macos*][arch=x86_64]' => '${PODS_TARGET_SRCROOT}/target/x86_64-apple-darwin',
    'LIBRARY_SEARCH_PATHS[sdk=macos*][arch=arm64]' => '${PODS_TARGET_SRCROOT}/target/aarch64-apple-darwin',
  }
end
