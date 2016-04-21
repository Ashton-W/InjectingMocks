import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if NSProcessInfo.processInfo().arguments.contains("--enableStubs") {
            let mainBundle = NSBundle.mainBundle()
            let path = mainBundle.builtInPlugInsURL?.URLByAppendingPathComponent("TubbleStubs.framework")
            
            if let path = path, let bundle = NSBundle(URL: path) {
                bundle.load()
            }
            else {
                assertionFailure()
            }
        }
        
        return true
    }

}

