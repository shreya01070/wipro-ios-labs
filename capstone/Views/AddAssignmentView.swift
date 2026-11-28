
import SwiftUI

struct AddAssignmentView: View {

    @ObservedObject var viewModel: CoursePlannerViewModel

    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var selectedCourseID: UUID?
    @State private var dueDate = Date()

    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            Form {

                Section("Assignment Details") {

                    TextField(
                        "Assignment title",
                        text: $title
                    )

                    Picker(
                        "Select Course",
                        selection: $selectedCourseID
                    ) {
                        Text("Choose a course")
                            .tag(nil as UUID?)

                        ForEach(viewModel.courses) { course in
                            Text(course.name)
                                .tag(course.id as UUID?)
                        }
                    }

                    DatePicker(
                        "Due Date",
                        selection: $dueDate,
                        displayedComponents: .date
                    )
                }

                Section {
                    Button("Save Assignment") {
                        saveAssignment()
                    }
                    .frame(maxWidth: .infinity)
                    .disabled(selectedCourseID == nil)
                }
            }
            .navigationTitle("Add Assignment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if selectedCourseID == nil {
                    selectedCourseID = viewModel.courses.first?.id
                }
            }
            .alert(
                "Unable to Add Assignment",
                isPresented: $showError
            ) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }

    private func saveAssignment() {

        guard let courseID = selectedCourseID else {
            errorMessage = "Please select a course."
            showError = true
            return
        }

        let error = viewModel.addAssignment(
            title: title,
            courseID: courseID,
            dueDate: dueDate
        )

        if let error = error {
            errorMessage = error
            showError = true
        } else {
            dismiss()
        }
    }
}
