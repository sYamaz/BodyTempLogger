//
//  InputViewModel.swift
//  BodyTempLogger (iOS)
//
//  Created by Shun Yamazaki on 2021/10/22.
//

import Foundation
import Combine
protocol SubmitViewModelDelegate{
    func submit(completion: @escaping (Bool, Error?) -> Void) -> Void
}

protocol InputTemperatureViewModelDelegate{
    func updateLower(_ val:Int) -> Void
    func updateHigher(_ val:Int) -> Void
}

class MockSubmitViewModel: SubmitViewModelDelegate{
    func submit(completion: @escaping (Bool, Error?) -> Void) {
        completion(true, nil)
    }
}

class MockInputTemperatureViewModel: InputTemperatureViewModelDelegate{

    
    func updateLower(_ val: Int) {
        
    }
    
    func updateHigher(_ val: Int) {
        
    }
}

class InputViewModel: ObservableObject, SubmitViewModelDelegate, InputTemperatureViewModelDelegate{
    @Published private (set) var preference:Preference
    private let temperatureStore:TemperatureStore
    private let repo:HealthCareRepositoryDelegate
    private var subscriptions = Set<AnyCancellable>()
    init(temperatureStore:TemperatureStore, preferenceStore:PreferenceStore, repo:HealthCareRepositoryDelegate){
        self.preference = preferenceStore.value
        self.temperatureStore = temperatureStore
        self.repo = repo
        // return cancellable object
        preferenceStore.$value
                       .sink(receiveValue: {v in self.preference = v})
                       .store(in: &subscriptions)
    }
    
    func updateLower(_ val:Int) -> Void{
        self.temperatureStore.update({old in old.lower(val)})
    }
    
    func updateHigher(_ val:Int) -> Void{
        self.temperatureStore.update({old in old.higher(val)})
    }
    
    func submit(completion: @escaping (Bool, Error?) -> Void) -> Void{
        let lower = temperatureStore.value.lower
        let higher = temperatureStore.value.higher
        let val:Double = Double(higher) + Double(lower) / 10
        
        self.repo.postBodyTemperature(val, unit: preference.unit, completion: completion)
    }
}
