
import SwiftUI

// Course Model

struct Course: Identifiable, Hashable {

    let id: String
    let name: String
    let category: String
    let duration: String
    let level: String
    let description: String

}

// Main Screen

struct ContentView: View {

    // Course data used throughout the application
    @State private var courses: [Course] = [

        Course(
            id: "1",
            name: "SwiftUI Fundamentals",
            category: "iOS Development",
            duration: "4 Weeks",
            level: "Beginner",
            description: "Learn the basics of SwiftUI, including views, layouts, modifiers and navigation."
        ),

        Course(
            id: "2",
            name: "Advanced Swift",
            category: "Programming",
            duration: "6 Weeks",
            level: "Intermediate",
            description: "Understand optionals, closures, protocols, error handling and advanced Swift concepts."
        ),

        Course(
            id: "3",
            name: "iOS App Development",
            category: "Mobile Development",
            duration: "8 Weeks",
            level: "Intermediate",
            description: "Build practical iOS applications using SwiftUI and learn how to structure projects."
        ),

        Course(
            id: "4",
            name: "UI and UX Design",
            category: "Design",
            duration: "3 Weeks",
            level: "Beginner",
            description: "Understand user interface design, usability and the fundamentals of user experience."
        )
    ]

    // Shared favourite state
    @State private var favouriteIDs: Set<String> = []

    var body: some View {

        NavigationStack {

            List {

                Section {
                    VStack(alignment: .leading, spacing: 8) {

                        Text("Course Explorer")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Explore courses and choose what you want to learn.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 10)
                }

                Section("Available Courses") {

                    if courses.isEmpty {

                        ContentUnavailableView(
                            "No Courses Available",
                            systemImage: "book.closed",
                            description: Text("Please check again later.")
                        )

                    } else {

                        ForEach(courses) { course in

                            NavigationLink {

                                CourseDetailView(
                                    course: course,
                                    isFavourite: favouriteBinding(for: course)
                                )

                            } label: {

                                CourseRow(
                                    course: course,
                                    isFavourite: favouriteIDs.contains(course.id),
                                    onFavouriteTap: {
                                        toggleFavourite(course)
                                    }
                                )
                            }
                        }
                    }
                }

                Section {

                    HStack {

                        Label(
                            "Favourite Courses",
                            systemImage: "heart.fill"
                        )

                        Spacer()

                        Text("\(favouriteIDs.count)")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.pink)
                }
            }
            .navigationTitle("My Learning")
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    NavigationLink {

                        RegistrationView(courses: courses)

                    } label: {

                        Image(systemName: "person.crop.circle.badge.plus")
                            .font(.title3)
                    }
                }
            }
        }
    }

    // Favourite Management

    private func toggleFavourite(_ course: Course) {

        if favouriteIDs.contains(course.id) {

            favouriteIDs.remove(course.id)

        } else {

            favouriteIDs.insert(course.id)
        }
    }

    // Both screens use the same favourite state
    private func favouriteBinding(for course: Course) -> Binding<Bool> {

        Binding(

            get: {
                favouriteIDs.contains(course.id)
            },

            set: { newValue in

                if newValue {

                    favouriteIDs.insert(course.id)

                } else {

                    favouriteIDs.remove(course.id)
                }
            }
        )
    }
}

// Reusable Course Row

struct CourseRow: View {

    let course: Course
    let isFavourite: Bool
    let onFavouriteTap: () -> Void

    var body: some View {

        HStack(spacing: 12) {

            Image(systemName: "book.fill")
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 45, height: 45)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 5) {

                Text(course.name)
                    .font(.headline)

                Text(course.category)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(course.duration)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Button(action: onFavouriteTap) {

                Image(
                    systemName: isFavourite
                    ? "heart.fill"
                    : "heart"
                )
                .foregroundColor(.pink)
                .font(.title3)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(
                isFavourite
                ? "Remove from favourites"
                : "Add to favourites"
            )
        }
        .padding(.vertical, 6)
    }
}

// Course Detail Screen

struct CourseDetailView: View {

    let course: Course

    @Binding var isFavourite: Bool

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 20) {

                Image(systemName: "book.closed.fill")
                    .font(.system(size: 65))
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 30)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(18)

                Text(course.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(course.category)
                    .font(.headline)
                    .foregroundColor(.blue)

                Divider()

                detailRow(
                    title: "Duration",
                    value: course.duration
                )

                detailRow(
                    title: "Difficulty",
                    value: course.level
                )

                VStack(alignment: .leading, spacing: 8) {

                    Text("About this course")
                        .font(.headline)

                    Text(course.description)
                        .foregroundColor(.secondary)
                }

                Button {

                    isFavourite.toggle()

                } label: {

                    Label(
                        isFavourite
                        ? "Remove from Favourites"
                        : "Add to Favourites",

                        systemImage: isFavourite
                        ? "heart.fill"
                        : "heart"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink.opacity(0.12))
                    .foregroundColor(.pink)
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func detailRow(
        title: String,
        value: String
    ) -> some View {

        HStack {

            Text(title)
                .foregroundColor(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.semibold)
        }
    }
}

// Registration Form

struct RegistrationView: View {

    let courses: [Course]

    @State private var studentName = ""
    @State private var email = ""
    @State private var selectedCourse = "SwiftUI Fundamentals"

    @State private var isSubmitting = false
    @State private var errorMessage = ""
    @State private var successMessage = ""

    var body: some View {

        Form {

            Section("Personal Information") {

                TextField("Enter your full name", text: $studentName)
                    .textInputAutocapitalization(.words)

                TextField("Enter your email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }

            Section("Course Selection") {

                Picker("Choose a Course", selection: $selectedCourse) {

                    ForEach(courses) { course in

                        Text(course.name)
                            .tag(course.name)
                    }
                }
            }

            Section {

                if !errorMessage.isEmpty {

                    Label(
                        errorMessage,
                        systemImage: "exclamationmark.circle.fill"
                    )
                    .foregroundColor(.red)
                }

                if !successMessage.isEmpty {

                    Label(
                        successMessage,
                        systemImage: "checkmark.circle.fill"
                    )
                    .foregroundColor(.green)
                }

                Button {

                    submitRegistration()

                } label: {

                    HStack {

                        Spacer()

                        if isSubmitting {

                            ProgressView("Submitting...")

                        } else {

                            Text("Submit Registration")
                                .fontWeight(.semibold)
                        }

                        Spacer()
                    }
                }
                .disabled(isSubmitting)
            }
        }
        .navigationTitle("Registration")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Form Validation

    private func submitRegistration() {

        errorMessage = ""
        successMessage = ""

        let name = studentName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let emailAddress = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        // Check empty fields
        guard !name.isEmpty else {

            errorMessage = "Please enter your name."
            return
        }

        // Basic email validation
        let emailParts = emailAddress.split(
            separator: "@",
            omittingEmptySubsequences: false
        )

        guard emailParts.count == 2,
              !emailParts[0].isEmpty,
              emailParts[1].contains("."),
              !emailParts[1].hasPrefix("."),
              !emailParts[1].hasSuffix(".") else {

            errorMessage = "Please enter a valid email address."
            return
        }

        guard !selectedCourse.isEmpty else {

            errorMessage = "Please select a course."
            return
        }

        // Show loading state
        isSubmitting = true

        // Simulate registration processing
        Task {

            try? await Task.sleep(
                nanoseconds: 1_000_000_000
            )

            isSubmitting = false

            successMessage = "Registration completed successfully!"

        }
    }
}

//  Preview

#Preview {
    ContentView()
}
