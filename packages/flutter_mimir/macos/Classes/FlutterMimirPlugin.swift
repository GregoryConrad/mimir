import Cocoa
import FlutterMacOS

public class FlutterMimirPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(nil)
    }

    public func dummyMethodToEnforceBundling() {
        enforce_binding() // disable tree shaking
    }
}