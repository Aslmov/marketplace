import UIKit
import Flutter
import GoogleMaps
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
<<<<<<< HEAD
    GMSServices.provideAPIKey("map key")
    GeneratedPluginRegistrant.register(with: self)
=======
    GMSServices.provideAPIKey("AIzaSyBTDMhiBGTNTieXxW-mI60jqRfhh_UD3aU")
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0, *) { 
     UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
>>>>>>> 1e8db651fdc2aa2bc4c5dc5fc8f10284992582f5
    application.registerForRemoteNotifications()
 UIApplication.shared.beginReceivingRemoteControlEvents()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
<<<<<<< HEAD
=======
var bgTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0);
    override func applicationDidEnterBackground(_ application: UIApplication) {
                bgTask = application.beginBackgroundTask()
    }
    override func applicationDidBecomeActive(_ application: UIApplication) {
        application.endBackgroundTask(bgTask);
    }
>>>>>>> 1e8db651fdc2aa2bc4c5dc5fc8f10284992582f5
}
