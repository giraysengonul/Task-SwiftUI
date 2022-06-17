//
//  ContentView.swift
//  Task-SwiftUI
//
//  Created by hakkı can şengönül on 17.06.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTIES
    @State var task : String = ""
    private var isbuttonDisabled : Bool{
        task.isEmpty
    }
    // MARK: - FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
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
        }
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                VStack( spacing: 16) {
                    TextField("New Task",text: $task)
                        .padding()
                        .background(
                            Color(uiColor: .systemGray6)
                        )
                        .cornerRadius(10)
                    
                    Button {
                        addItem()
                    } label: {
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                    .disabled(isbuttonDisabled)
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(
                        isbuttonDisabled ? Color.gray : Color.pink
                    )
                    .cornerRadius(10)
                    
                }//:VStack
                .padding()
                
                
                List {
                    ForEach(items) { item in
                        
                        VStack(alignment: .leading) {
                            Text(item.task ?? "")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        
                    }
                    .onDelete(perform: deleteItems)
                }//List
                
            }//:VStack
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
            }
            .navigationTitle("Daily Task")
            .navigationBarTitleDisplayMode(.large)
            Text("Select an item")
            
        }.navigationViewStyle(.stack)
        
    }
    
    
}


// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
