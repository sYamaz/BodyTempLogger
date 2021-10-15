//

import SwiftUI
import HealthKit
import Swift
@main
struct BodyTempLoggerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView(repo: appDelegate.repo)
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let repo:HealthCareRepositoryDelegate = HealthCareRepository()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if(repo.setup())
        {
            return true
        }
        
        return false
    }
}
