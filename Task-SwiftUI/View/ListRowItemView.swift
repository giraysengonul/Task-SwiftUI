//
//  ListRowItemView.swift
//  Task-SwiftUI
//
//  Created by hakkı can şengönül on 18.06.2022.
//

import SwiftUI

struct ListRowItemView: View {
    @ObservedObject var item : Item
    @Environment(\.managedObjectContext) var viewContext
   
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : Color.primary)
                .padding(.vertical,12)
                
        } //:Toggle
       
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
               
        }
        .toggleStyle(CheckboxStyle())
    }
}

