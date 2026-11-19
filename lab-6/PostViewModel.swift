import SwiftUI

@MainActor
class PostViewModel: ObservableObject {

    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let postService = PostService()

    func loadPosts() async {

        isLoading = true
        errorMessage = nil

        do {
            let result = try await postService.fetchPosts()

            if result.isEmpty {
                throw APIError.emptyData
            }

            posts = result

        } catch let error as APIError {

            errorMessage = error.localizedDescription

        } catch {

            errorMessage = "Network error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
