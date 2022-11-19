# We cannot distribute the XCFramework alongside the library directly,
# so we have to fetch the latest version here.
version = 'v0'
url = "https://github.com/GregoryConrad/mimir/releases/download/#{version}/EmbeddedMilli.xcframework.zip"
`
cd Frameworks
curl #{url} --output EmbeddedMilli.xcframework.zip
unzip EmbeddedMilli.xcframework.zip
rm EmbeddedMilli.xcframework.zip
cd -
`

Pod::Spec.new do |spec|
  spec.name          = 'flutter_mimir'
  spec.version       = '0.0.1'
  spec.license       = { :file => '../LICENSE' }
  spec.homepage      = 'https://github.com/GregoryConrad/mimir'
  spec.authors       = { 'Gregory Conrad' => 'gregorysconrad@gmail.com' }
  spec.summary       = 'Embedded instance of milli for flutter_mimir'

  spec.source              = { :path => '.' }
  spec.source_files        = 'Classes/**/*'
  spec.public_header_files = 'Classes/**/*.h'
  spec.vendored_frameworks = 'Frameworks/EmbeddedMilli.xcframework'

  spec.ios.deployment_target = '11.0'
  spec.osx.deployment_target = '10.11'
end
