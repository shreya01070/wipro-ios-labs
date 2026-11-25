
import SwiftUI

struct ContentView: View {

    // Shared course data
    @StateObject private var store = CourseStore()

    // Local state for search and filtering
    @State private var searchText = ""
    @State private var showFavoritesOnly = false

    // Filter courses based on search text and favourite status
    private var filteredCourses: [Course] {

        store.courses.filter { course in

            let matchesSearch = searchText.isEmpty ||
                course.name.localizedCaseInsensitiveContains(searchText) ||
                course.category.localizedCaseInsensitiveContains(searchText)

            let matchesFavorite = !showFavoritesOnly || course.isFavorite

            return matchesSearch && matchesFavorite
        }
    }

    var body: some View {

        NavigationStack {

            VStack(spacing: 12) {

                // App heading
                VStack(alignment: .leading, spacing: 6) {

                    Text("Course Explorer")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Explore courses and save your favourites.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                // Show only favourite courses
                Toggle(
                    "Show favourite courses only",
                    isOn: $showFavoritesOnly
                )
                .padding(.horizontal)

                // Course list
                List {

                    if filteredCourses.isEmpty {

                        emptyMessage

                    } else {

                        ForEach(filteredCourses) { course in

                            CourseRowView(
                                course: course,
                                isFavorite: favoriteBinding(for: course.id)
                            )
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .listRowInsets(
                                EdgeInsets(
                                    top: 7,
                                    leading: 12,
                                    bottom: 7,
                                    trailing: 12
                                )
                            )
                        }
                    }
                }
                .listStyle(.plain)
                .searchable(
                    text: $searchText,
                    prompt: "Search courses"
                )
            }
            .navigationTitle("My Courses")
            .navigationBarTitleDisplayMode(.inline)

            // Open the selected course details
            .navigationDestination(for: Course.self) { selectedCourse in

                CourseDetailView(
                    course: selectedCourse,
                    isFavorite: favoriteBinding(for: selectedCourse.id)
                )
            }
        }
    }

    // Create a binding connected to CourseStore
    private func favoriteBinding(for courseID: Int) -> Binding<Bool> {

        Binding(
            get: {
                store.isFavorite(courseID)
            },
            set: { newValue in
                store.setFavorite(newValue, for: courseID)
            }
        )
    }

    // Empty state when no courses match
    private var emptyMessage: some View {

        VStack(spacing: 12) {

            Image(systemName: "book.closed")
                .font(.system(size: 40))
                .foregroundColor(.gray)

            Text("No Courses Found")
                .font(.headline)

            Text("Try another search or check your favourite filter.")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 45)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

#Preview {
    ContentView()
}

