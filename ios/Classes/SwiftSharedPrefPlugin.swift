import Flutter
import UIKit

public class SwiftSharedPrefPlugin: NSObject, FlutterPlugin {
    static let methodChannelName = "com.elaunch.shared_pref"
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: registrar.messenger())
        let instance = SwiftSharedPrefPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getInstance":
            let userDefaults = UserDefaults.standard
            let bundleIdentifier = Bundle.main.bundleIdentifier!
            let allValues = userDefaults.persistentDomain(forName: bundleIdentifier)
            let filteredPref = allValues?.filter({ (element) -> Bool in
                element.key.hasPrefix("flutter.")
            })
            var values = Dictionary<String, Any>()
            filteredPref?.forEach({ element in
                let key = element.key.prefix(8)
                print(key)
                values[String(key)] = element.value
            })
            result(values)
            break
        case "setValue":
            onSetValues(call, result: result)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
}

    func onSetValues(_ call:FlutterMethodCall, result: FlutterResult){
        guard let args = call.arguments as? [String:Any?] else{
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments passed to method call.", details: nil))
            return
        }
        let key = args["key"] as! String
        let value = args["value"] as Any
        UserDefaults.standard.set(value, forKey: key)
        result(true)
    }
}
