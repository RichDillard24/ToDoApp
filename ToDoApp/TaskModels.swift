import Foundation


struct TaskItem: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
    
}

struct TaskGroup: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

// Mock Data

extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(
            title: "School",
            symbolName: "book.fill",
            tasks: [
                TaskItem( title: "Grade Assignment"),
                TaskItem( title: "Math Test"),
            ]),
        TaskGroup(
            title: "Home",
            symbolName: "house.fill",
            tasks: [
                TaskItem( title: "Groceries"),
                TaskItem( title: "Laundry", isCompleted: true)
            ])
    ]
}
