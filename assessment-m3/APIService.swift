
import Foundation

enum APIError: Error {
    case invalidResponse
}

struct APIService {

    private let urlString = "https://jsonplaceholder.typicode.com/posts"

    func fetchPosts() async throws -> [Post] {

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {

            throw APIError.invalidResponse
        }

        let decoder = JSONDecoder()

        let posts = try decoder.decode([Post].self, from: data)

        return posts
    }
}
