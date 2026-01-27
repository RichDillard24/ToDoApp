import SwiftUI

struct GroupsStatsView: View {
    
    var task: [TaskItem]
    var completedCount: Int {task.filter { $0.isCompleted }.count}
    var progress: Double {
        task.isEmpty ? 0 : Double(completedCount) / Double(task.count)
    }
    
    
    
    var body: some View {
        HStack{
            ZStack{
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(Color.blue)
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth:10, lineCap: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .bold()
            }
            .frame(width: 60, height: 60)
            .padding()
            
            VStack(alignment: .leading) {
                Text("Task Progress")
                Text("\(completedCount)/\(task.count)Completed")
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

