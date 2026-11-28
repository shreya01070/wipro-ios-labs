
import SwiftUI

@main
struct CoursePlannerApp: App {

    @StateObject private var viewModel = CoursePlannerViewModel()

    var body: some Scene {
        WindowGroup {

            TabView {

                DashboardView(viewModel: viewModel)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }

                CoursesView(viewModel: viewModel)
                    .tabItem {
                        Label("Courses", systemImage: "book.fill")
                    }

                AssignmentsView(viewModel: viewModel)
                    .tabItem {
                        Label("Assignments", systemImage: "checklist")
                    }
            }
        }
    }
}
