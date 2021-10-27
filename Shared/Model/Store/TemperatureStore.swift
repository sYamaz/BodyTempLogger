//
//  TemperatureStore.swift
//  BodyTempLogger (iOS)
//
//  Created by Shun Yamazaki on 2021/10/22.
//

import Foundation
import Combine
class TemperatureStore: ObservableObject{

    @Published private (set) var value:Temperature
    
    init(_ initialValue:Temperature){
        self.value = initialValue
    }
    
    func update(_ closure:(Temperature) -> Temperature) -> Void{
        self.value = closure(self.value)
    }
}
