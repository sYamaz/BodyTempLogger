//

import SwiftUI
import HealthKit
import Swift
@main
struct BodyTempLoggerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            let tempStore:TemperatureStore = .init(.init(lower: 5, higher: 36))
            let prefStore:PreferenceStore = .init(.init(unit: .degreeCelsius, color: .init(r: 0x7f, g: 0x7f, b: 0x7f), celsiusRange: .lowRange))
            let repo = appDelegate.repo
            ContentView(
                inputVM: .init(temperatureStore: tempStore, preferenceStore: prefStore, repo: repo),
                preferenceViewModel: .init(store: prefStore),
                displayViewModel: .init(repo: repo, store: tempStore)
            )
        }
    }
    
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let repo:HealthCareRepositoryDelegate = HealthCareRepository()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if(repo.setup() == false)
        {
            return false
        }
        
        //
        // TODO: Storeのロード
        //
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        //
        // TODO: Storeの保存
        //
    }
}
