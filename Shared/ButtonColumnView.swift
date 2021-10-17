//
//  ButtonColumnView.swift
//  BodyTempLogger
//
//  Created by Shun Yamazaki on 2021/10/15.
//

import SwiftUI

struct ButtonColumnView<T>: View {
    @Binding var val:T
    let items:[T]
    
    init(val:Binding<T>, items:[T]){
        self._val = val
        self.items = items
    }
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            ForEach(items.indices){i in
                let label = "\(items[i])"
                Button(label){
                    val = items[i]
                }
                
            }
        }
    }
}

struct ButtonColumnView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonColumnView<Int>(val: .constant(1), items: [0,1,2])
    }
}
