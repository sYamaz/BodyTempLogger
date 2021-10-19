//

import SwiftUI

struct PostView: View {
    let text1 = "登録"
    let text2 = "登録中..."
    @State var errorOccur:Bool = false
    @State var text:String = "登録"
    var temp:Double
    let repository:HealthCareRepositoryDelegate
    let completion:(Bool,Error?)->Void
    init(_ temp:Double, repo:HealthCareRepositoryDelegate){
        self.temp = temp
        self.repository = repo
        completion = {(s, e) in }
    }
    
    init(_ temp:Double, repo:HealthCareRepositoryDelegate, completion:@escaping (Bool, Error?) -> Void){
        self.temp = temp
        self.repository = repo
        self.completion = completion
    }
    
    var body: some View {
        Button(action: {
            text = text2
            repository.postBodyTemperature(temp, unit: .degreeCelsius){ (success, error) in
                completion(success, error)
                text = text1
            }
        }){
            Text(text)
                .padding()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(36.6, repo:PreviewHealthCareRepository())
    }
}
