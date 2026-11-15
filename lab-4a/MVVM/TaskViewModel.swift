import Foundation
import Combine

class TaskViewModel: ObservableObject {

    @Published var tasks: [Task] = []
    @Published var filter: TaskFilter = .all
    @Published var newTaskTitle = ""
    @Published var errorMessage: String?

    var filteredTasks: [Task] {
        switch filter {
        case .all:
            return tasks
        case .active:
            return tasks.filter { !$0.isCompleted }
        case .completed:
            return tasks.filter { $0.isCompleted }
        }
    }

    // Add a task to the list.
    func addTask() {
        let title = newTaskTitle.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !title.isEmpty else {
            errorMessage = "Please enter a task name."
            return
        }

        let task = Task(title: title, isCompleted: false)
        tasks.append(task)

        newTaskTitle = ""
        errorMessage = nil
    }

    // Mark a task as completed or active.
    func toggleCompletion(for task: Task) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }

        tasks[index].isCompleted.toggle()
    }

    // Delete tasks selected from the filtered list.
    func deleteTask(at offsets: IndexSet) {
        let selectedIDs = offsets.map { filteredTasks[$0].id }

        tasks.removeAll { selectedIDs.contains($0.id) }
    }
}
