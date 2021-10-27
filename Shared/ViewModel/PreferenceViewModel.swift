//
//  PreferenceViewModel.swift
//  BodyTempLogger (iOS)
//
//  Created by Shun Yamazaki on 2021/10/22.
//

import Foundation
import Combine
class PreferenceViewModel: ObservableObject{
    @Published private (set) var preference:Preference
    private let store:PreferenceStore
    private var subscriptions = Set<AnyCancellable>()
    init(store: PreferenceStore){
        self.store = store
        self.preference = store.value
        
        store.$value
             .sink(receiveValue: {v in self.preference = v})
             .store(in: &subscriptions)
                
    }
    
    func changeCelsiusRange(_ range:CelsiusRange) -> Void{
        self.store.update { old in old.changeCelsiusRange(range)}
    }
}
