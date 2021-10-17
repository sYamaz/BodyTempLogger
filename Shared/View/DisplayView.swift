//
//  DisplayView.swift
//  BodyTempLogger
//
//  Created by Shun Yamazaki on 2021/10/18.
//

import SwiftUI

extension DisplayView{
    private init(upperVal:Int, lowerVal:Int, upperColor:Color, lowerColor:Color){
        self.upperVal = upperVal
        self.lowerVal = lowerVal
        self.upperValueColor = upperColor
        self.lowerValueColor = lowerColor
    }
    
    func upperColor(_ color:Color) -> Self{
        return DisplayView(upperVal: self.upperVal, lowerVal: self.lowerVal, upperColor: color, lowerColor: self.lowerValueColor)
    }
    
    func lowerColor(_ color:Color) -> Self{
        return DisplayView(upperVal: self.upperVal, lowerVal: self.lowerVal, upperColor: self.upperValueColor, lowerColor: color)
    }
}

struct DisplayView: View {
    let upperVal:Int
    let lowerVal:Int
    let upperValueColor:Color
    let lowerValueColor:Color
    
    init(upperVal:Int, lowerVal:Int){
        self.upperVal = upperVal
        self.lowerVal = lowerVal
        
        self.upperValueColor = Color.primary
        self.lowerValueColor = Color.primary
    }
    
    var body: some View {
        // 表示
        HStack(alignment: .firstTextBaseline, spacing: 4){
            Text("\(upperVal).")
                .foregroundColor(upperValueColor)
            Text("\(lowerVal)")
                .foregroundColor(lowerValueColor)
            Text("℃").font(Font.system(size: 48))
        }.font(Font.system(size: 80))
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView(upperVal: 36, lowerVal: 5)
            .upperColor(Color.red)
            .lowerColor(Color.blue)
    }
}
