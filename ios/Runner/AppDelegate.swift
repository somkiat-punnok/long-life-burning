import UIKit
import Flutter
import Firebase
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("AIzaSyApxB8Xjrg0m-ayriRwcXQpNVz0ONsXlGE")
        FirebaseApp.configure()
        GeneratedPluginRegistrant.register(with: self)
        if(![[NSUserDefaults standardUserDefaults]objectForKey:@"Notification"]){
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Notification"];
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
