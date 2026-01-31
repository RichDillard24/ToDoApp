
import SwiftUI


struct ContentView: View {
    
    @State private var taskGroups: [TaskGroup] = []
    @State private var selectedGroup : TaskGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "SvaedTaskGroups"
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        isDarkMode.toggle()
                    } label: {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button{
                        isShowingAddGroup = true
                    } label : {
                        Image(systemName: "plus")
                    }
                }
            }
    
            } detail: {
                if let group = selectedGroup {
                    if let index = taskGroups.firstIndex(where: { $0.id == group.id}){
                        TaskGroupDetailView(groups: $taskGroups[index])
                    }
                } else {
                    ContentUnavailableView(" Select a group to see more details", systemImage: "sidebar.left")
                }
            }
            .onAppear{
                loadData()
            }
            .onChange(of: scenePhase) { oldValue, newValue in
                if newValue == .active {
                    print("App is running active")
                } else if newValue == .inactive {
                    print("App is currently innactive")
                } else if newValue == .background {
                    print("App is in background mode - saving data!")
                    saveData()
                }
                
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            
            .sheet(isPresented: $isShowingAddGroup){
                NewGroupView { newGroup in
                    taskGroups.append(newGroup)
                    selectedGroup = newGroup
                }
            }
        }
        func saveData() {
            if let encodedData = try? JSONEncoder().encode(taskGroups) {
                UserDefaults.standard.set(encodedData, forKey: saveKey)
            }
        }
        func loadData() {
            if let savedData = UserDefaults.standard.data(forKey: saveKey){
                if let decodeGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData){
                    taskGroups = decodeGroups
                    return
                }
            }
            taskGroups = TaskGroup.sampleData
        }
    }


#Preview {
    ContentView()
    
}


