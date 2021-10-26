//
//  MenuBarView.swift
//  BodyTempLogger (iOS)
//
//  Created by Shun Yamazaki on 2021/10/22.
//

import SwiftUI

struct MenuBarView: View {
    @State private var settingMode:Bool = false
    @ObservedObject private var vm:PreferenceViewModel
    
    init(vm:PreferenceViewModel){
        self.vm = vm
    }
    
    private func convertToColor(_ val:ThemeColor) -> Color{
        return .init(red: val.r, green: val.g, blue: val.b)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: nil){
            HStack(alignment: .center, spacing: nil){
                Spacer()
                Button("設定"){
                    settingMode = true
                }.sheet(isPresented: $settingMode, onDismiss:{}, content: {
                    VStack(alignment:.center, spacing: nil){
                        
                        let rangeBind = Binding<Bool>.init {
                            switch vm.preference.celsiusRange {
                            case .lowRange:
                                return false
                            case .highRange:
                                return true
                            }
                        } set: { newValue in
                            if(newValue){
                                vm.changeCelsiusRange(.highRange)
                            }else{
                                vm.changeCelsiusRange(.lowRange)
                            }
                        }

                        
                        List(){
                            Toggle.init("36℃~39℃にする", isOn: rangeBind)
                            
                        }
                    }
                })
            }
        }
    }
}

struct MenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView(vm: PreferenceViewModel(store: PreferenceStore(.init(unit: .degreeCelsius, color: .init(r: 0x7F, g: 0x7F, b: 0x7F), celsiusRange: .lowRange))))
    }
}
