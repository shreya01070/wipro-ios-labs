import SwiftUI

struct TaskListView: View {

    @StateObject private var viewModel = TaskViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {

                // Task input section
                HStack {
                    TextField(
                        "Enter a task...",
                        text: $viewModel.newTaskTitle
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Add") {
                        viewModel.addTask()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                }

                // Choose which tasks to display
                Picker("Filter", selection: $viewModel.filter) {
                    ForEach(TaskFilter.allCases) { option in
                        Text(option.rawValue.capitalized)
                            .tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // Display tasks
                List {
                    ForEach(viewModel.filteredTasks) { task in
                        HStack {
                            Text(task.title)
                                .strikethrough(task.isCompleted)
                                .foregroundColor(
                                    task.isCompleted ? .gray : .primary
                                )

                            Spacer()

                            Image(
                                systemName: task.isCompleted
                                ? "checkmark.circle.fill"
                                : "circle"
                            )
                            .foregroundColor(
                                task.isCompleted ? .green : .gray
                            )
                            .onTapGesture {
                                viewModel.toggleCompletion(for: task)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
            }
            .navigationTitle("My Tasks")
        }
    }
}
