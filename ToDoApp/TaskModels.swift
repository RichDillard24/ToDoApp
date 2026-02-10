import Foundation


struct TaskItem: Identifiable, Hashable, Codable{
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    
}

struct TaskGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

struct Profile: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var profileImage: String
    var groups: [TaskGroup]
    
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

extension Profile {
    static let sample: [Profile] = [
        Profile(
            name: "Rich Dillard",
            profileImage: "professor_img",
            groups: TaskGroup.sampleData),
        Profile(
            name: "Joe Schmoe",
            profileImage: "student_img",
            groups: [] ),
    ]
}
