//

import SwiftUI
import Combine
struct TapInputView: View {
    let uppers = [35, 36, 37, 38]
    @State var degree:Double = 0
    @State var lowerVal:Int = 0
    @State var upperVal:Int = 36
    
    let repo:HealthCareRepositoryDelegate
    
    var body: some View {
        let upperColor = Color.red
        let lowerColor = Color.blue
        VStack(alignment: .center, spacing: nil){
            Spacer()
            HStack(alignment: .firstTextBaseline, spacing: 0){
                Text("\(upperVal).")
                    .foregroundColor(upperColor)
                Text("\(lowerVal)")
                    .foregroundColor(lowerColor)
            }.font(.title)

            GeometryReader{g in
                HStack(alignment: .center, spacing: 0){
                    ButtonGridView<Int>(val: $upperVal, cols: [.init(items: uppers)])
                        .foregroundColor(upperColor)
                        .frame(width: g.size.width * 0.33)
                    ButtonGridView<Int>(val: $lowerVal, cols: [
                        .init(items: [7,4,1]),
                        .init(items: [8,5,2,0]),
                        .init(items: [9,6,3])
                    ])
                        .foregroundColor(lowerColor)
                        .frame(width: g.size.width * 0.67)
                }
            }
            PostView(Double(upperVal) + Double(lowerVal)/10, repo: repo)
        }.padding()
        
    }
    
    func upperButton(text:String, click:@escaping() -> Void) -> some View{
        return Button(text){
            click()
        }
    }
    func lowerButton(text:String, click:@escaping() -> Void) -> some View{
        return Button(text){
            click()
        }
    }
}

struct TapInputView_Previews: PreviewProvider {
    static var previews: some View {
        TapInputView(repo: PreviewHealthCareRepository())
    }
}



