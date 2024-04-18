public enum HTTPMethod: String {
    case get = "GET"
}

public protocol Endpoint {
    var baseURL: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
}
