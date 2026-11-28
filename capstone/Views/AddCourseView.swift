
import SwiftUI

struct AddCourseView: View {

    @ObservedObject var viewModel: CoursePlannerViewModel

    @Environment(\.dismiss) private var dismiss

    @State private var courseName = ""
    @State private var instructorName = ""
    @State private var duration = 8

    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            Form {

                Section("Course Details") {

                    TextField(
                        "Enter course name",
                        text: $courseName
                    )

                    TextField(
                        "Enter instructor name",
                        text: $instructorName
                    )

                    Stepper(
                        "Duration: \(duration) weeks",
                        value: $duration,
                        in: 1...52
                    )
                }

                Section {
                    Button("Save Course") {
                        saveCourse()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Add Course")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Unable to Add Course", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }

    private func saveCourse() {

        let error = viewModel.addCourse(
            name: courseName,
            instructor: instructorName,
            durationWeeks: duration
        )

        if let error = error {
            errorMessage = error
            showError = true
        } else {
            dismiss()
        }
    }
}
