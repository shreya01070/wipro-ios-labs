
import SwiftUI

struct DashboardView: View {

    @ObservedObject var viewModel: CoursePlannerViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Welcome back!")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Keep your learning organized.")
                            .foregroundStyle(.secondary)
                    }

                    // Summary cards
                    HStack(spacing: 12) {
                        summaryCard(
                            title: "Courses",
                            value: "\(viewModel.courses.count)",
                            symbol: "book.fill"
                        )

                        summaryCard(
                            title: "Assignments",
                            value: "\(viewModel.assignments.count)",
                            symbol: "doc.text.fill"
                        )
                    }

                    // Progress section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Overall Progress")
                            .font(.headline)

                        HStack {
                            Text("\(viewModel.completionPercentage)%")
                                .font(.title2)
                                .fontWeight(.bold)

                            Spacer()

                            Text(
                                "\(viewModel.completedAssignments.count) of \(viewModel.assignments.count) completed"
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }

                        ProgressView(
                            value: Double(viewModel.completionPercentage),
                            total: 100
                        )
                        .tint(.green)
                    }
                    .padding()
                    .background(
                        Color(.secondarySystemBackground)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    // Upcoming assignments
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Upcoming Assignments")
                            .font(.headline)

                        if viewModel.pendingAssignments.isEmpty {
                            ContentUnavailableView(
                                "No Pending Assignments",
                                systemImage: "checkmark.circle",
                                description: Text(
                                    "You're all caught up!"
                                )
                            )
                        } else {
                            ForEach(
                                Array(viewModel.pendingAssignments.prefix(5))
                            ) { assignment in

                                VStack(alignment: .leading, spacing: 5) {
                                    Text(assignment.title)
                                        .fontWeight(.medium)

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
                                    .foregroundStyle(.orange)
                                }
                                .padding(.vertical, 6)

                                Divider()
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Course Planner")
        }
    }

    private func summaryCard(
        title: String,
        value: String,
        symbol: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: symbol)
                .font(.title2)
                .foregroundStyle(.blue)

            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(title)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
