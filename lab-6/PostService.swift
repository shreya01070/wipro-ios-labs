import Foundation

class PostService {

    private let apiURL: String

    init(apiURL: String = "https://jsonplaceholder.typicode.com/posts") {
        self.apiURL = apiURL
    }

    func fetchPosts() async throws -> [Post] {

        guard let components = URLComponents(string: apiURL),
              let url = components.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.serverError(0)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode([Post].self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}

enum APIError: LocalizedError {

    case invalidURL
    case serverError(Int)
    case decodingError
    case emptyData

    var errorDescription: String? {

        switch self {

        case .invalidURL:
            return "Invalid API URL."

        case .serverError(let code):
            return "Server returned status code: \(code)"

        case .decodingError:
            return "Unable to decode JSON data."

        case .emptyData:
            return "No posts available."
        }
    }
}
