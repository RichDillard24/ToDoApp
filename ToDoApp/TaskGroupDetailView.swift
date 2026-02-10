import SwiftUI



struct TaskGroupDetailView: View {
    
    @Binding var groups : TaskGroup
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        List {
            
            Section{
                if sizeClass == .regular {
                    GroupsStatsView(task: groups.tasks)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color(.secondarySystemBackground))
                }
                
                ForEach($groups.tasks) { $task in
                    HStack {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(task.isCompleted ? .cyan : .gray)
                            .onTapGesture{
                                withAnimation{
                                    task.isCompleted.toggle()
                                }
                            }
                            .accessibilityIdentifier("Toggle: \(task.id)")
                        
                        TextField("New Task", text: $task.title)
                            .strikethrough(task.isCompleted)
                            .foregroundStyle(task.isCompleted ? .gray : .primary)
                            .accessibilityIdentifier("Task: \(task.title)")
                        
                    }
                }
                .onDelete{ index in
                    groups.tasks.remove(atOffsets: index)
                }
            }
        }
        .navigationTitle(groups.title)
            .toolbar {
                Button("Add Task") {
                    withAnimation {
                        groups.tasks.append(TaskItem(title: ""))
                    }
                }
                .accessibilityIdentifier("Add_Task")
            }
    }
}

