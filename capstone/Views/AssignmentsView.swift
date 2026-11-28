
import SwiftUI

struct AssignmentsView: View {

    @ObservedObject var viewModel: CoursePlannerViewModel

    @State private var showAddAssignment = false
    @State private var selectedFilter = "Pending"

    private var displayedAssignments: [Assignment] {
        if selectedFilter == "Completed" {
            return viewModel.completedAssignments
        }

        if selectedFilter == "All" {
            return viewModel.assignments.sorted {
                $0.dueDate < $1.dueDate
            }
        }

        return viewModel.pendingAssignments
    }

    var body: some View {
        NavigationStack {
            VStack {

                Picker("Filter", selection: $selectedFilter) {
                    Text("Pending").tag("Pending")
                    Text("Completed").tag("Completed")
                    Text("All").tag("All")
                }
                .pickerStyle(.segmented)
                .padding()

                if displayedAssignments.isEmpty {
                    ContentUnavailableView(
                        "No Assignments",
                        systemImage: "doc.text",
                        description: Text(
                            "There are no assignments in this section."
                        )
                    )
                } else {
                    List {
                        ForEach(displayedAssignments) { assignment in

                            HStack(spacing: 12) {

                                Button {
                                    viewModel.toggleAssignment(
                                        id: assignment.id
                                    )
                                } label: {
                                    Image(
                                        systemName: assignment.isCompleted
                                        ? "checkmark.circle.fill"
                                        : "circle"
                                    )
                                    .font(.title2)
                                    .foregroundStyle(
                                        assignment.isCompleted
                                        ? .green
                                        : .secondary
                                    )
                                }
                                .buttonStyle(.plain)

                                VStack(alignment: .leading, spacing: 5) {

                                    Text(assignment.title)
                                        .fontWeight(.medium)
                                        .strikethrough(
                                            assignment.isCompleted
                                        )

                                    Text(
                                        viewModel.courseName(
                                            for: assignment.courseID
                                        )
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                    Text(
                                        "Due: \(assignment.dueDate.formatted(date: .abbreviated, time: .omitted))"
                                    )
                                    .font(.caption)
                                    .foregroundStyle(
                                        assignment.isCompleted
                                        ? .green
                                        : .orange
                                    )
                                }
                            }
                            .padding(.vertical, 5)
                        }
                        .onDelete { indexSet in
                            let assignmentIDs = indexSet.map {
                                displayedAssignments[$0].id
                            }

                            assignmentIDs.forEach {
                                viewModel.deleteAssignment(id: $0)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Assignments")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddAssignment = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(viewModel.courses.isEmpty)
                }
            }
            .sheet(isPresented: $showAddAssignment) {
                AddAssignmentView(viewModel: viewModel)
            }
        }
    }
}
