
import SwiftUI

struct CoursesView: View {

    @ObservedObject var viewModel: CoursePlannerViewModel

    @State private var showAddCourse = false

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.courses.isEmpty {
                    ContentUnavailableView(
                        "No Courses Yet",
                        systemImage: "book",
                        description: Text(
                            "Tap + to add your first course."
                        )
                    )
                } else {
                    List {
                        ForEach(viewModel.courses) { course in

                            VStack(alignment: .leading, spacing: 7) {
                                Text(course.name)
                                    .font(.headline)

                                Text(
                                    "Instructor: \(course.instructor.isEmpty ? "Not specified" : course.instructor)"
                                )
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                                Text(
                                    "Duration: \(course.durationWeeks) weeks"
                                )
                                .font(.caption)
                                .foregroundStyle(.blue)

                                let taskCount = viewModel.assignments.filter {
                                    $0.courseID == course.id
                                }.count

                                Text("\(taskCount) assignments")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 5)
                        }
                        .onDelete { indexSet in
                            let courseIDs = indexSet.map {
                                viewModel.courses[$0].id
                            }

                            courseIDs.forEach {
                                viewModel.deleteCourse(id: $0)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Courses")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddCourse = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddCourse) {
                AddCourseView(viewModel: viewModel)
            }
        }
    }
}
