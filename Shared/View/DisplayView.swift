//
//  DisplayView.swift
//  BodyTempLogger
//
//  Created by Shun Yamazaki on 2021/10/18.
//

import SwiftUI

extension DisplayView{
    private init(vm:DisplayViewModel, upperColor:Color, lowerColor:Color){
        self.vm = vm
        self.upperValueColor = upperColor
        self.lowerValueColor = lowerColor
    }
    
    func upperColor(_ color:Color) -> Self{
        return DisplayView(vm: self.vm, upperColor: color, lowerColor: self.lowerValueColor)
    }
    
    func lowerColor(_ color:Color) -> Self{
        return DisplayView(vm: self.vm, upperColor: self.upperValueColor, lowerColor: color)
    }
}

struct DisplayView: View {
    
    private let upperValueColor:Color
    private let lowerValueColor:Color
    
    @ObservedObject private var vm:DisplayViewModel
    
    init(vm:DisplayViewModel){
        self.vm = vm
        
        self.upperValueColor = Color.primary
        self.lowerValueColor = Color.primary
    }
    
    var body: some View {
        // 表示
        HStack(alignment: .firstTextBaseline, spacing: 4){
            Text("\(vm.temp.higher).")
                .foregroundColor(upperValueColor)
            Text("\(vm.temp.lower)")
                .foregroundColor(lowerValueColor)
            Text("℃").font(Font.system(size: 48))
        }.font(Font.system(size: 80))
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView(vm: .init(repo: PreviewHealthCareRepository(), store: .init(.init(lower: 5, higher: 36))))
            .upperColor(Color.red)
            .lowerColor(Color.blue)
    }
}
