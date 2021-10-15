//

import Foundation
import HealthKit

enum BodyTemperatureUnit{
    /// 摂氏
    case degreeCelsius
    /// 華氏
    case degreeFahrenheit
}

protocol HealthCareRepositoryDelegate{
    
    func setup() -> Bool
    
    /// 体温データを保存します
    /// - Parameters:
    ///   - value: 体温データ
    ///   - unit: 摂氏または華氏を選択します
    ///   - completion: 処理が完全に完了した時のコールバックです
    /// - Returns: Void
    func postBodyTemperature(_ value:Double, unit:BodyTemperatureUnit, completion:@escaping (Bool, Error?) -> Void) -> Void
}

///
/// 必要に応じて使用する。プレビュー用
///
class PreviewHealthCareRepository:HealthCareRepositoryDelegate{
    func setup() -> Bool{
        return true
    }
    
    func postBodyTemperature(_ value: Double, unit: BodyTemperatureUnit, completion: @escaping (Bool, Error?) -> Void) {
        completion(true, nil)
    }
}

class HealthCareRepository:HealthCareRepositoryDelegate {
    let allTypes = Set([HKObjectType.quantityType(forIdentifier: .bodyTemperature)!])
    /// HKHealthStoreはアプリケーションあたり1インスタンス。１回生成したらそれを使い続ける必要あり
    var store:HKHealthStore? = nil
    
    func setup() -> Bool{
        /// ipadではヘルスケア使えない
        /// https://developer.apple.com/documentation/healthkit/setting_up_healthkit
        /// Ensure HealthKit’s Availability
        if (HKHealthStore.isHealthDataAvailable() == false){
            // ヘルスデータが無効状態
            return false
        }
        
        /// ヘルスケア機能があり、有効である場合生成する
        self.store = HKHealthStore()
        return true
    }

    func postBodyTemperature(_ value:Double, unit:BodyTemperatureUnit, completion:@escaping (Bool, Error?) -> Void) -> Void{
        
        /// https://developer.apple.com/documentation/healthkit/authorizing_access_to_health_data
        /// Request Permission from the User
        /// toShare: Write要求
        /// read: Read要求
        self.store!.requestAuthorization(toShare: allTypes, read: nil){ (success, error) in
            if !success{
                completion(success, error)
                return
            }
            
            /// https://developer.apple.com/documentation/healthkit/authorizing_access_to_health_data
            /// Check for Authorization Before Saving Data
            let status = self.store!.authorizationStatus(for: .quantityType(forIdentifier: .bodyTemperature)!)
            switch status{
            case .notDetermined:
                // "If you have not yet requested permission"
                // ここに入ることはないはず
                print("Not determined")
                completion(false, HKError(HKError.errorAuthorizationNotDetermined))
                return
            case .sharingDenied:// If the user has denied permission
                // ユーザーが許可しなかった場合
                print("Sharing Denied")
                completion(false, HKError(HKError.errorAuthorizationDenied))
                break
            case .sharingAuthorized:
                // ユーザーが許可した場合
                print("Sharing Authorized")
                break
            @unknown default:
                print("Unknown status.")
                break
            }
            
            // Datetime
            let now = Date()
            // 摂氏 or 華氏
            let hkUnit:HKUnit
            switch unit {
            case .degreeCelsius:
                hkUnit = .degreeCelsius()
            case .degreeFahrenheit:
                hkUnit = .degreeFahrenheit()
            }
            
            let quantity = HKQuantity(unit: hkUnit, doubleValue: value)
            let obj = HKQuantitySample(type: .quantityType(forIdentifier: .bodyTemperature)!, quantity: quantity, start: now, end: now)
            self.store!.save(obj, withCompletion: completion)
        }
    }
}
