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
    @AppStorage("isDarkMode") private var isDarkMode : Bool = false
    @State var task : String = ""
    @State private var showNewTaskItem : Bool = false
    
    // MARK: - FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - FUNCTION

    
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
            ZStack {
                 // MARK: - MAIN VIEW
                
                
                VStack {
                   // MARK: - HEADER
                    
                    HStack( spacing: 10) {
                    //TITLE
                        Text("Task")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading,4)
                        Spacer()
                        
                        
                    //EDIT BUTTON
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal,10)
                            .frame(minWidth:70,minHeight: 24)
                            .background(Capsule().stroke(Color.white,lineWidth: 2))
                        
                        
                        
                    //APPEARANCE BUTTON
                        
                        Button {
                            isDarkMode.toggle()
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title,design: .rounded))
                        }

                        
                        
                        
                    }//:HStack
                    .padding()
                    .foregroundColor(Color.white)
                    
                    Spacer(minLength: 90)
                    
                    
                     // MARK: - NEW TASK BUTTON
                    Button {
                        showNewTaskItem = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30,weight: .semibold,design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal,20)
                    .padding(.vertical,15)
                    .background(LinearGradient(colors: [Color.pink, Color.blue], startPoint: .leading, endPoint: .trailing)).clipShape(Capsule())
                    .shadow(color: .black.opacity(0.24), radius: 8, x: 0, y: 4)

                    
                     // MARK: - TASKS
                    
                    
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
                    .listStyle(.insetGrouped)
                    .shadow(color: .black.opacity(0.3), radius: 12)
                    .padding(.vertical,0)
                    .frame(maxWidth: 640)
                    // MARK: - NEW TASK ITEM
                   
                }//:VStack
               
                
                
                
                .onAppear(perform: {
                    UITableView.appearance().backgroundColor = .clear
                })
                .navigationBarHidden(true)
                    .navigationTitle("Daily Task")
                .navigationBarTitleDisplayMode(.large)
                .background(BackgroundImageView())
                .background(backgroundGradient.ignoresSafeArea(.all))
                if showNewTaskItem {
                    BlankView().onTapGesture {
                        withAnimation {
                            showNewTaskItem = false
                        }
                    }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }//:ZStack
           
           
        }.navigationViewStyle(.stack)
        
    }
    
    
}


// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
