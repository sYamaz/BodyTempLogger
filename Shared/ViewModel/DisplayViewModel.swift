//
//  DisplayViewModel.swift
//  BodyTempLogger (iOS)
//
//  Created by Shun Yamazaki on 2021/10/21.
//

import Foundation
import Combine
class DisplayViewModel: ObservableObject{
    private let healthCareRepository: HealthCareRepositoryDelegate
    @Published private (set) var temp:Temperature
    
    private var cancellable:AnyCancellable? = nil
    
    init(repo:HealthCareRepositoryDelegate, store:TemperatureStore) {
        self.healthCareRepository = repo
        self.temp = store.value
        
        self.cancellable = store.$value.sink(receiveValue: {t in self.temp = t})
        // こっちはコンストラクタ抜けると破棄されてしまう感じ
        //let _ = store.sub.sink(receiveValue: {t in self.update(t)})
    }
}
