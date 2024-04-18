enum DrawEndpoint {
    case rounds
}

extension DrawEndpoint: Endpoint {
    var baseURL: String {
        return "https://www.canada.ca"
    }
    
    var endpoint: String {
        switch self {
        case .rounds:
            return "/content/dam/ircc/documents/json/ee_rounds_123_en.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .rounds:
            return .get
        }
    }
    
    
}
