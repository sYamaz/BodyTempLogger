//
//  ErrorMessageView.swift
//  BodyTempLogger (iOS)
//
//  Created by Shun Yamazaki on 2021/10/20.
//

import SwiftUI

struct ErrorMessageView: View {
    let error:Error?
    init(_ error:Error?){
        self.error = error
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: nil){
            if let e = error {
                let errorTxt = "\(e)"
                Text(errorTxt)
                    .padding()
            }
        }
    }
}

struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView(nil)
    }
}
