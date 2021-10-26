//

import SwiftUI
struct ContentView: View {
    @State private var error:Error? = nil
    let inputVM:InputViewModel
    let preferenceViewModel:PreferenceViewModel
    let displayViewModel:DisplayViewModel
    
    var body: some View {
        ZStack(alignment: .top){
            GeometryReader{g in
                VStack(alignment: .center, spacing: nil){
                    // menu
                    MenuBarView(vm: preferenceViewModel)
                    Spacer()
                    DisplayView(vm: displayViewModel)
                        .upperColor(.green)
                        .lowerColor(.green.opacity(0.6))
                    TapInputView(vm: inputVM, width: g.size.width)
                        .upperColor(.green)
                        .lowerColor(.green.opacity(0.6))
                    PostView(vm: inputVM, completion: {(sucess, error) in
                        self.error = error})
                        .font(Font.system(size: 24))
                        .frame(width: g.size.width * 0.66, alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(16)
                }
            }
            ErrorMessageView(self.error)
        }.padding()
    }
}
                                    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let prefStore:PreferenceStore = .init(.init(unit: .degreeCelsius, color: .init(r: 0x7f, g: 0x7f, b: 0x7f), celsiusRange: .lowRange))
        let tempStore:TemperatureStore = .init(.init(lower: 5, higher: 36))
        let repo = PreviewHealthCareRepository()
        ContentView(
            inputVM: .init(temperatureStore: tempStore, preferenceStore: prefStore, repo: repo),
            preferenceViewModel: .init(store: prefStore),
            displayViewModel: .init(repo: repo, store: tempStore))
    }
}
