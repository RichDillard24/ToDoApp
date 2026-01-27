import SwiftUI

struct NewGroupView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var groupName = ""
    @State private var selectedIcon = "list.bullet"
    
    let icons = ["list.bullet", "bookmark.fill", "graduationcap.fill", "cart.fill", "house.fill", "star.fill"]
    
    var onSave: (TaskGroup) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Group Name") {
                    TextField("Type name of group", text: $groupName)
                }
                
                Section("Select Icon") {
                    LazyVGrid(columns: [ GridItem(.adaptive(minimum:40))]) {
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .font(.title2)
                                .frame(width: 40, height: 40 )
                                .background(selectedIcon == icon ? Color.cyan : Color.clear)
                                .foregroundStyle(selectedIcon == icon ? Color.blue : Color.gray)
                                .clipShape(Circle())
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("New Group")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .confirmationAction){
                    Button("save") {
                        let newGroup = TaskGroup(title: groupName, symbolName: selectedIcon, tasks: [])
                        onSave(newGroup)
                        dismiss()
                    }
                    .disabled(groupName.isEmpty)
                }
            }
        }
    }
}
