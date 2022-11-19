# We cannot distribute the XCFramework alongside the library directly,
# so we have to fetch the latest version here.
version = 'v0'
framework_name = 'EmbeddedMilli.xcframework'
zip_name = "#{framework_name}.zip"
url = "https://github.com/GregoryConrad/mimir/releases/download/#{version}/#{zip_name}"
`
cd Frameworks
rm #{framework_name}
curl -OL #{url}
unzip #{zip_name}
rm #{zip_name}
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
  spec.vendored_frameworks = "Frameworks/#{framework_name}"

  spec.ios.deployment_target = '11.0'
  spec.osx.deployment_target = '10.11'
end
