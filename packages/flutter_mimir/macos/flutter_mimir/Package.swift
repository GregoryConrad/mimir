// swift-tools-version: 5.9

import PackageDescription
import Foundation

if shell("bash", "fetch-binary.sh") != 0 {
   print("Failed to download the Mimir binaries")
}

// Permission error:
try "hi".write(to: URL(fileURLWithPath: "/tmp/test.txt"), atomically: true, encoding: .utf8)

let package = Package(
    name: "flutter_mimir",
    platforms: [
        .iOS("12.0"),
        .macOS("10.14")
    ],
    products: [
        .library(name: "flutter-mimir", targets: ["EmbeddedMilli"])
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "EmbeddedMilli",
            path: "Frameworks/EmbeddedMilli.xcframework"
        )
    ]
)

@discardableResult
func shell(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}
