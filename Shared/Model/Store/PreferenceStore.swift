//
//  PreferenceStore.swift
//  BodyTempLogger (iOS)
//
//  Created by Shun Yamazaki on 2021/10/22.
//

import Foundation
class PreferenceStore: ObservableObject{
    @Published private (set) var value:Preference
    
    init(_ initialValue:Preference){
        self.value = initialValue
    }
    
    func update(_ closure:(Preference) -> Preference) -> Void{
        self.value = closure(self.value)
    }
}
