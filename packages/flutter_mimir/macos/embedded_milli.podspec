Pod::Spec.new do |spec|
    spec.name          = 'embedded_milli'
    spec.version       = '0.0.1'
    spec.license       = { :file => '../LICENSE'}
    spec.homepage      = 'https://github.com/GregoryConrad/mimir'
    spec.authors       = { 'Gregory Conrad' => 'gregorysconrad@gmail.com' }
    spec.summary       = 'Embedded instance of milli'

    # This will ensure the source files in Classes/ are included in the native
    # builds of apps using this FFI plugin. Podspec does not support relative
    # paths, so Classes contains a forwarder C file that relatively imports
    # `../src/*` so that the C sources can be shared among all target platforms.
    s.source           = { :path => '.' }
    s.source_files     = 'Classes/**/*'
    s.dependency 'FlutterMacOS'
  
    s.platform = :osx, '10.11'
    s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
    s.swift_version = '5.0'
  end
  