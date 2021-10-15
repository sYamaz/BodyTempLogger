//

import SwiftUI

struct KeyboardInputView: View {
    @State var temp:String = ""
    @State var isInvalidInput:Bool = false
    @State var degree:Double = 0
    let repository:HealthCareRepositoryDelegate
    var body: some View {
        VStack(alignment: .center, spacing: nil){
            TextField("36.5", text: $temp)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.trailing)
                .padding()
                .onChange(of: temp){v in
                    guard let tmpDegree = Double(temp) else{
                        isInvalidInput = true
                        return
                    }
                    isInvalidInput = false
                    degree = tmpDegree
                }

            PostView(degree, repo:repository)
                .disabled(isInvalidInput)
                .padding()
        }.padding()
    }
}

struct KeyboardInputView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardInputView(repository: PreviewHealthCareRepository())
    }
}
