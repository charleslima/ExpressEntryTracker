enum DrawEndpoint {
    case rounds
}

extension DrawEndpoint: Endpoint {
    var baseURL: String {
        return Config.host
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
