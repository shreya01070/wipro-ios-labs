import Foundation
import Combine

//Task 1: MVVM and Task Management

struct TaskItem: Identifiable, Equatable {
    let id: UUID
    var title: String
    var isCompleted: Bool
}

@MainActor
class TaskListViewModel: ObservableObject {

    @Published private(set) var tasks: [TaskItem] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    func loadTasks() async {
        isLoading = true
        errorMessage = nil

        do {
            // Waiting for a short time to simulate an API call
            try await Task.sleep(nanoseconds: 500_000_000)

            tasks = [
                TaskItem(id: UUID(), title: "Review architectural patterns", isCompleted: true),
                TaskItem(id: UUID(), title: "Implement concurrent data fetching", isCompleted: false),
                TaskItem(id: UUID(), title: "Write view model unit tests", isCompleted: false)
            ]

            isLoading = false

        } catch {
            errorMessage = "Unable to load tasks: \(error.localizedDescription)"
            isLoading = false
        }
    }

    func toggleTask(_ task: TaskItem) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }

        tasks[index].isCompleted.toggle()
    }
}


//Task 2: Fetching Data at the Same Time

struct UserProfile: Sendable {
    let username: String
}

struct UserSettings: Sendable {
    let theme: String
}

class UserDashboardService {

    private func fetchProfile() async throws -> UserProfile {
        try await Task.sleep(nanoseconds: 300_000_000)
        return UserProfile(username: "SwiftCoder99")
    }

    private func fetchSettings() async throws -> UserSettings {
        try await Task.sleep(nanoseconds: 300_000_000)
        return UserSettings(theme: "Dark")
    }

    func loadDashboardData() async throws -> (profile: UserProfile, settings: UserSettings) {

        // Both functions can run together instead of waiting for each other
        async let profile = fetchProfile()
        async let settings = fetchSettings()

        let user = try await profile
        let preferences = try await settings

        return (user, preferences)
    }
}


//Task 3: Managing Different View States

enum ViewState<T> {
    case idle
    case loading
    case success(T)
    case error(Error)
}

actor DataFetcherViewModel {

    private(set) var state: ViewState<String> = .idle
    private var currentTask: Task<Void, Never>?

    func fetchData() {

        // Stop the previous request if another one is started
        currentTask?.cancel()
        state = .loading

        currentTask = Task {
            do {
                try await Task.sleep(nanoseconds: 1_000_000_000)

                guard !Task.isCancelled else {
                    return
                }

                state = .success("Data fetched successfully!")

            } catch {
                guard !Task.isCancelled else {
                    return
                }

                state = .error(error)
            }
        }
    }

    func cancelLoading() {
        currentTask?.cancel()
        currentTask = nil
        state = .idle
    }
}


// Main Program

@main
struct MilestoneApp {

    static func main() async {

        print(" Milestone 2 Demonstration \n")

        // Task 1: Checking the task list
        let viewModel = TaskListViewModel()
        await viewModel.loadTasks()

        print("Task 1: Total tasks loaded = \(viewModel.tasks.count)")


        // Task 2: Loading profile and settings together
        let dashboardService = UserDashboardService()

        do {
            let result = try await dashboardService.loadDashboardData()

            print("Task 2: Username = \(result.profile.username)")
            print("Task 2: Theme = \(result.settings.theme)")

        } catch {
            print("Task 2: Something went wrong - \(error)")
        }


        // Task 3: Testing the loading process
        let dataFetcher = DataFetcherViewModel()
        await dataFetcher.fetchData()

        print("Task 3: Data fetching has started.")

        print("\n Program finished ")
    }
}
