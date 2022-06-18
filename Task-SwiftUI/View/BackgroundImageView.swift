//
//  BackgroundImageView.swift
//  Task-SwiftUI
//
//  Created by hakkı can şengönül on 17.06.2022.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        
        Image("rocket")
        //kenar yumuşatma
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
    }
}
