release_tag_name="mimir-v0.1.0" # generated; do not edit
# TODO update version script to remove space and point to this dir

set -e

# We cannot distribute the XCFramework alongside the library directly,
# so we have to fetch the correct version here.
framework_name="EmbeddedMilli.xcframework"
remote_zip_name="$framework_name.zip"
url="https://github.com/GregoryConrad/mimir/releases/download/$release_tag_name/$remote_zip_name"
local_zip_name="$release_tag_name.zip"

pushd Frameworks
rm -rf $framework_name

if [ ! -f $local_zip_name ]
then
  curl -L $url -o $local_zip_name
fi

unzip $local_zip_name
popd
