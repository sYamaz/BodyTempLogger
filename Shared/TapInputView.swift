//

import SwiftUI
import Combine
struct TapInputView: View {
    @State var error:Error? = nil
    
    @State var degree:Double = 0
    @State var lowerVal:Int = 0
    @State var upperVal:Int = 36
    @State var settingMode:Bool = false
    
    @State var offset:Bool = false
    
    let repo:HealthCareRepositoryDelegate
    
    var body: some View {
        let upperThemeColor = Color.red
        let lowerThemeColor = Color.blue
        
        let upperForeColor = upperThemeColor
        let lowerForeColor = lowerThemeColor
        let upperBackColor = Color.init(white: 0.85)
        let lowerBackColor = Color.init(white: 0.85)
        
        let commonSpacing:CGFloat = 4
        let commonRadius:CGFloat = 16
        ZStack(alignment: .top){
            GeometryReader{g in
                let width = g.size.width
                let colWidth = width * 0.25
                let rowHeight = colWidth
                
                
                VStack(alignment: .center, spacing: nil){
                    HStack(alignment: .center, spacing: nil){
                        Spacer()
                        Button("設定"){
                            settingMode = true
                        }.sheet(isPresented: $settingMode, onDismiss:{}, content: {
                            VStack(alignment:.center, spacing: nil){
                                List(){
                                    Toggle.init("36℃~39℃にする", isOn: $offset)
                                }
                            }
                        })
                    }
                    Spacer()
                    // 表示
                    HStack(alignment: .firstTextBaseline, spacing: commonSpacing){
                        Text("\(upperVal).")
                            .foregroundColor(upperThemeColor)
                        Text("\(lowerVal)")
                            .foregroundColor(lowerThemeColor)
                        Text("℃").font(Font.system(size: 48))
                    }.font(Font.system(size: 80))
                    // 入力ボタン
                    HStack(alignment: .top, spacing: commonSpacing){
                        let col0 = [35, 36, 37, 38]
                        let col1 = [7, 4, 1]
                        let col2 = [8, 5, 2, 0]
                        let col3 = [9, 6, 3]
                        VStack(alignment: .center, spacing: commonSpacing ){
                            ForEach(col0.indices){i in
                                let val = col0[i] + (offset ? 1 : 0)
                                let label = "\(val)"
                                Button(label){
                                    self.upperVal = val
                                }
                                .frame(width: colWidth, height: rowHeight)
                                .background(upperBackColor)
                                .cornerRadius(commonRadius)
                            }
                        }
                        .font(Font.system(size: 24))
                        .foregroundColor(upperForeColor)
                        VStack(alignment: .center, spacing: commonSpacing ){
                            ForEach(col1.indices){i in
                                let label = "\(col1[i])"
                                Button(label){
                                    self.lowerVal = col1[i]
                                }
                                .frame(width: colWidth, height: rowHeight)
                                .background(lowerBackColor)
                                .cornerRadius(commonRadius)
                            }
                        }
                        .font(Font.system(size:24))
                        .foregroundColor(lowerForeColor)
                        VStack(alignment: .center, spacing: commonSpacing ){
                            ForEach(col2.indices){i in
                                let label = "\(col2[i])"
                                Button(label){
                                    self.lowerVal = col2[i]
                                }
                                .frame(width: colWidth, height: rowHeight)
                                .background(lowerBackColor)
                                .cornerRadius(commonRadius)
                            }
                        }
                        .font(Font.system(size: 24))
                        .foregroundColor(lowerForeColor)
                        VStack(alignment: .center, spacing: commonSpacing ){
                            ForEach(col3.indices){i in
                                let label = "\(col3[i])"
                                Button(label){
                                    self.lowerVal = col3[i]
                                }
                                .frame(width: colWidth, height: rowHeight)
                                .background(lowerBackColor)
                                .cornerRadius(commonRadius)
                            }
                        }
                        .font(Font.system(size: 24))
                        .foregroundColor(lowerForeColor)
                    }
                    
                    // 登録ボタン
                    PostView(Double(upperVal) + Double(lowerVal)/10, repo: repo){(success, error) in
                        // completion
                        
                        self.error = error
                        
                        
                    }
                    .font(Font.system(size: 24))
                    .frame(width: g.size.width * 0.66, alignment: .center)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(commonRadius)
                    
                }
                
            }.padding()
            
            
            
            VStack(alignment: .trailing, spacing: nil){
                if let e = error {
                    let errorTxt = "\(e)"
                    Text(errorTxt)
                        .padding()
                }
            }
        }
    }
}

struct TapInputView_Previews: PreviewProvider {
    static var previews: some View {
        TapInputView(repo: PreviewHealthCareRepository())
            .preferredColorScheme(.dark)
    }
}



