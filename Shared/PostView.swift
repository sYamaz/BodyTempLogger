//

import SwiftUI

struct PostView: View {
    var temp:Double
    let repository:HealthCareRepositoryDelegate
    init(_ temp:Double, repo:HealthCareRepositoryDelegate){
        self.temp = temp
        self.repository = repo
    }
    var body: some View {
        Button("登録"){
            print(temp)
            repository.postBodyTemperature(temp, unit: .degreeCelsius){ (success, error) in
                if(success == false){
                    print(error!)
                }else{
                    print("success")
                }
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(36.6, repo:PreviewHealthCareRepository())
    }
}
