import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // CRITICAL: Register Flutter plugins FIRST, before any SDK initialization
    // This must happen first to prevent dyld crashes during framework loading
    GeneratedPluginRegistrant.register(with: self)
    
    // Setup notification delegate
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    
    // IMPORTANT: Delay Google Maps initialization until after Flutter engine is ready
    // This prevents dyld crashes by ensuring proper framework loading order
    // The Flutter engine must be fully initialized before third-party SDKs
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
      self?.initializeGoogleMaps()
    }
    
    // Set up method channel for device detection
    self.setupMethodChannel()
    
    // Call super AFTER Flutter plugins are registered
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func initializeGoogleMaps() {
    // Initialize Google Maps after Flutter engine is fully ready
    // This delay prevents dyld crashes that occur when frameworks load in wrong order
    GMSServices.provideAPIKey("AIzaSyDKh1ef1o9DUMQH1-LQsFj0W-y1mcozrdk")
  }
  
  private func setupMethodChannel(retryCount: Int = 0) {
    // Use a slight delay to ensure Flutter engine is ready
    DispatchQueue.main.async {
      guard let controller = self.window?.rootViewController as? FlutterViewController else {
        // If not ready and we haven't exceeded retries, try again shortly
        if retryCount < 10 {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.setupMethodChannel(retryCount: retryCount + 1)
          }
        }
        return
      }
      
      let deviceChannel = FlutterMethodChannel(
        name: "com.example.fecApp2/device",
        binaryMessenger: controller.binaryMessenger
      )
      
      deviceChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
        if call.method == "isIPad" {
          let isIPad = UIDevice.current.userInterfaceIdiom == .pad
          result(isIPad)
        } else {
          result(FlutterMethodNotImplemented)
        }
      }
    }
  }
}
