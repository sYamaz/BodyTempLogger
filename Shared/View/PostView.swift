//

import SwiftUI

struct PostView: View {
    let text1 = "登録"
    let text2 = "登録中..."
    @State var errorOccur:Bool = false
    @State var text:String = "登録"
    let completion: (Bool,Error?)->Void
    let vm:SubmitViewModelDelegate
    init(vm:SubmitViewModelDelegate){
        self.vm = vm
        completion = {(s, e) in }
    }
    
    init(vm:SubmitViewModelDelegate, completion:@escaping (Bool, Error?) -> Void){
        self.vm = vm
        self.completion = completion
    }
    
    var body: some View {
        
        let closure:(Bool, Error?) -> Void = {(s, e) in
            completion(s, e)
            text = text1
        }
        
        Button(action: {
            text = text2
            vm.submit(completion: closure)
        }){
            Text(text)
                .padding()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(vm: MockSubmitViewModel())
    }
}
