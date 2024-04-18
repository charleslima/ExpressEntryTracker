public protocol IAPIClient {
    func request<T: Decodable>(endPoint: Endpoint) async throws -> T
}

public struct APIClient: IAPIClient {
    
    let decoder: APIDecoder
    let session: URLSession = URLSession.shared
    
    public init(decoder: APIDecoder = V1Decoder()) {
        self.decoder = decoder
    }
    
    public func request<T: Decodable>(endPoint: Endpoint) async throws -> T {
        guard let url = URL(string: endPoint.baseURL + endPoint.endpoint) else {
            throw APIClientError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        let (data, _) = try await session.data(for: urlRequest)
        
        return try decoder.decode(from: data)
    }
}

enum APIClientError: Error {
    case invalidURL
}
