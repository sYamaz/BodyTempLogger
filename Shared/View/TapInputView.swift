//

import SwiftUI
import Combine

extension TapInputView{
    private init(vm:InputViewModel, width:CGFloat, upperColor:Color, lowerColor:Color){
        self.vm = vm
        self.width = width
        self.upperColor = upperColor
        self.lowerColor = lowerColor
    }
    
    func upperColor(_ val:Color) -> Self{
        return .init(vm: self.vm, width: self.width, upperColor: val, lowerColor: self.lowerColor)
    }
    
    func lowerColor(_ val:Color) -> Self{
        return .init(vm: self.vm, width: self.width, upperColor: self.upperColor, lowerColor: val)
    }
}

struct TapInputView: View {
    let upperColor:Color
    let lowerColor:Color
    
    @ObservedObject private var vm:InputViewModel
    let width:CGFloat
    init(vm:InputViewModel, width:CGFloat){
        self.vm = vm
        self.width = width
        self.upperColor = Color.green
        self.lowerColor = Color.green.opacity(0.6)
    }
    
    var body: some View {
        let commonSpacing:CGFloat = 4
        let commonRadius:CGFloat = 16
        let columnCount:CGFloat = 4
        let colWidth = (width - (commonSpacing * (columnCount - 1))) * 0.25
        let rowHeight = colWidth
        
        
        VStack(alignment: .center, spacing: nil){
            // 入力ボタン
            HStack(alignment: .top, spacing: commonSpacing){
                let col0 = [35, 36, 37, 38]
                let col1 = [7, 4, 1]
                let col2 = [8, 5, 2, 0]
                let col3 = [9, 6, 3]
                
                let offset = vm.preference.celsiusRange == .highRange
                
                VStack(alignment: .center, spacing: commonSpacing ){
                    ForEach(col0.indices){i in
                        let val = col0[i] + (offset ? 1 : 0)
                        let label = "\(val)"
                        Button(label){
                            vm.updateHigher(val)
                        }
                        .frame(width: colWidth, height: rowHeight)
                        .background(self.upperColor)
                        .cornerRadius(commonRadius)
                    }
                }
                .font(Font.system(size: 24))
                .foregroundColor(Color.white)
                VStack(alignment: .center, spacing: commonSpacing ){
                    ForEach(col1.indices){i in
                        let label = "\(col1[i])"
                        Button(label){
                            vm.updateLower(col1[i])
                        }
                        .frame(width: colWidth, height: rowHeight)
                        .background(self.lowerColor)
                        .cornerRadius(commonRadius)
                    }
                }
                .font(Font.system(size:24))
                .foregroundColor(Color.white)
                VStack(alignment: .center, spacing: commonSpacing ){
                    ForEach(col2.indices){i in
                        let label = "\(col2[i])"
                        Button(label){
                            vm.updateLower(col2[i])
                        }
                        .frame(width: colWidth, height: rowHeight)
                        .background(self.lowerColor)
                        .cornerRadius(commonRadius)
                    }
                }
                .font(Font.system(size: 24))
                .foregroundColor(Color.white)
                VStack(alignment: .center, spacing: commonSpacing ){
                    ForEach(col3.indices){i in
                        let label = "\(col3[i])"
                        Button(label){
                            vm.updateLower(col3[i])
                        }
                        .frame(width: colWidth, height: rowHeight)
                        .background(self.lowerColor)
                        .cornerRadius(commonRadius)
                    }
                }
                .font(Font.system(size: 24))
                .foregroundColor(Color.white)
            }
        }
    }
}

struct TapInputView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{g in
            TapInputView(vm: .init(temperatureStore: .init(.init(lower: 5, higher: 36)), preferenceStore: .init(.init(unit: .degreeCelsius, color: .init(r: 0x7f, g: 0x7f, b: 0x7f), celsiusRange: .highRange)), repo: PreviewHealthCareRepository()), width: g.size.width)
                .preferredColorScheme(.dark)
        }
    }
}



