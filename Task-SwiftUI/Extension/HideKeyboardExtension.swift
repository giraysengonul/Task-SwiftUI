//
//  HideKeyboardExtension.swift
//  Task-SwiftUI
//
//  Created by hakkı can şengönül on 17.06.2022.
//

import SwiftUI
//klavye kapatmak için
#if canImport(UIKit)
extension View{
    
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}



#endif
