//

import SwiftUI
struct ContentView: View {
    let repo:HealthCareRepositoryDelegate
    var body: some View {
        TapInputView(repo: repo)
    }
}
                                    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(repo: PreviewHealthCareRepository())
    }
}
