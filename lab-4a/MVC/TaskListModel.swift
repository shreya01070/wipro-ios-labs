import Foundation

class TaskListModel {

    private(set) var tasks: [Task] = []
    var currentFilter: TaskFilter = .all

    var filteredTasks: [Task] {
        switch currentFilter {
        case .all:
            return tasks
        case .active:
            return tasks.filter { !$0.isCompleted }
        case .completed:
            return tasks.filter { $0.isCompleted }
        }
    }

    // Add a new task after checking its title.
    func addTask(title: String) -> Bool {
        let cleanedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanedTitle.isEmpty else {
            return false
        }

        let task = Task(title: cleanedTitle, isCompleted: false)
        tasks.append(task)
        return true
    }

    // Change the completion status of a task.
    func toggleTask(_ task: Task) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }

        tasks[index].isCompleted.toggle()
    }

    // Remove the selected task.
    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
}
