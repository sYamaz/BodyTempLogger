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

final class Store<T> : ObservableObject{
    @Published private var value:T
    
    init(_ initialValue:T){
        self.value = initialValue
    }
    
    func update(_ closure:(T) -> T) -> Void{
        self.value = closure(self.value)
    }
    
    func onReceive(_ receivedValue:@escaping(T) -> Void) -> AnyCancellable{
        return self.$value.sink(receiveValue: receivedValue)
    }
}

protocol TemperatureStoreDelegate{
    func onReceive(_ receiveValue:@escaping(Temperature) -> Void) -> AnyCancellable
    func update(_ closure:(Temperature) -> Temperature) -> Void
}
