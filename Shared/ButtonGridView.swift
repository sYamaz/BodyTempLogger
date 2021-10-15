//

import SwiftUI

struct ButtonGridCol<T>{
    let items:[T]
}

struct ButtonGridView<T>: View{

    let cols:[ButtonGridCol<T>]
    @Binding var val:T
    
    init(val:Binding<T>, cols:[ButtonGridCol<T>]){
        self._val = val
        self.cols = cols
    }
    
    var body: some View{
        HStack(alignment: .top, spacing: nil){
            Spacer()
            ForEach(cols.indices){col in
                let colVals = cols[col]
                VStack(alignment: .center, spacing: nil){
                    ForEach(colVals.items.indices){row in
                        let v = colVals.items[row]
                        let label = "\(v)"
                        Button(label){
                            val = v
                        }
                        .padding()
                        .border(Color.black)
                    }
                }
                Spacer()
            }
        }
    }
}

struct ButtonGridView_Previews: PreviewProvider {
    static var previews: some View {
        let datas = [
            ButtonGridCol(items: [7,4,1]),
            ButtonGridCol(items:[8,5,2,0]),
            ButtonGridCol(items:[9,6,3])
        ]
        ButtonGridView<Int>(val: .constant(0), cols: datas)
    }
}
