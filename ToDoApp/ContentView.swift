
import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var taskGroups: [TaskGroup] = []
    @State private var selectedGroup : TaskGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "SvaedTaskGroups"
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("selectedLanguage") private var selectedLanguage: String = "en"
    
    @Environment(\.locale) private var locale
    let languageKey = "selectedLanguage"
    
    @Environment(\.dismiss) private var dismiss
    @Binding var profile: Profile
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(selection: $selectedGroup){
                ForEach(profile.groups){ group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                    .accessibilityIdentifier("Task_Groups")
                }
                
                
            }
            .navigationTitle(profile.name)
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                       dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .accessibilityIdentifier("back")
                }
                ToolbarItem(placement: .primaryAction) {
                    Button{
                        isShowingAddGroup = true
                    } label : {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("Add_Group")
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(language.allCases) { language in
                            Text(language.name).tag(language)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .accessibilityIdentifier("Language_Selection")
                }
             
            }
    
            } detail: {
                if let group = selectedGroup {
                    if let index = profile.groups.firstIndex(where: { $0.id == group.id}){
                        TaskGroupDetailView(groups: $profile.groups[index])
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
            
            .navigationSplitViewStyle(.balanced)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $isShowingAddGroup){
                NewGroupView { newGroup in
                    profile.groups.append(newGroup)
                    selectedGroup = newGroup
                        
                }
            }
        }
        func saveData() {
            if let encodedData = try? JSONEncoder().encode(profile.groups) {
                UserDefaults.standard.set(encodedData, forKey: saveKey)
            }
        }
        
        func loadData() {
            if let savedData = UserDefaults.standard.data(forKey: saveKey){
                if let decodeGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData){
                    profile.groups = decodeGroups
                    return
                }
            }
            if profile.groups.isEmpty {
                profile.groups = TaskGroup.sampleData
            }
        }
    }





