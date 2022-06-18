//
//  NewTaskItemView.swift
//  Task-SwiftUI
//
//  Created by hakkı can şengönül on 17.06.2022.
//

import SwiftUI

struct NewTaskItemView: View {
    // MARK: - PROPERTY
    @AppStorage("isDarkMode") private var isDarkMode : Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task : String = ""
    @Binding var isShowing : Bool
    private var isbuttonDisabled : Bool{
        task.isEmpty
    }
    // MARK: - FUNCTION
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyboard()
            isShowing = false
        }
        
    }
    // MARK: - BODY
    
    var body: some View {
        VStack {
            Spacer()
            VStack( spacing: 16) {
                TextField("New Task",text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                
                Button {
                    addItem()
                } label: {
                    Spacer()
                    Text("Save")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                }
                .disabled(isbuttonDisabled)
                .padding()
                
                .foregroundColor(.white)
                .background(
                    isbuttonDisabled ? Color.blue : Color.pink
                )
                .cornerRadius(10)
                
            }//:VStack
            .padding(.horizontal)
            .padding(.vertical,20)
            .background(isDarkMode ? Color(uiColor: .secondarySystemBackground) : Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.65), radius: 24)
            .frame(maxWidth: 640)
        }//:VStack
        .padding()
    }
}


// MARK: - PREVIEW
struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true)).background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
