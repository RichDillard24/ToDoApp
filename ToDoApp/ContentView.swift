
import SwiftUI


struct ContentView: View {
    
    @State private var taskGroups = TaskGroup.sampleData
    @State private var selectedGroup : TaskGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            
            List(selection: $selectedGroup){
                ForEach(taskGroups){ group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
                
            }
            .navigationTitle("Things to Do")
            .listStyle(.sidebar)
        } detail: {
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: { $0.id == group.id}){
                    TaskGroupDetailView(group: $taskGroups[index])
                }
            } else {
                ContentUnavailableView(" Select a group to see more details", systemImage: "sidebar.left")
            }
        }
    }
}
#Preview {
    ContentView()
}
