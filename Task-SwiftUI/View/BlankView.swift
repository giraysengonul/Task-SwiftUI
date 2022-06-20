//
//  BlankView.swift
//  Task-SwiftUI
//
//  Created by hakkı can şengönül on 17.06.2022.
//

import SwiftUI
 
struct BlankView: View {
    // MARK: - PROPERTY
   var backgroundColor : Color
   var backgroundOpacity : Double
    
    
     // MARK: - BODY
    var body: some View {
        VStack{
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .edgesIgnoringSafeArea(.all)
        .blendMode(.overlay)
    }
}

 // MARK: - PREVIEW
struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgroundColor: Color.black, backgroundOpacity: 0.3).background(BackgroundImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
    }
}
