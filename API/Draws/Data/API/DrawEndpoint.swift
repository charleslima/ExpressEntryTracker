enum DrawEndpoint {
    case rounds
}

var count = 0

extension DrawEndpoint: Endpoint {
    var baseURL: String {
        return "https://www.canada.ca"
    }
    
    var endpoint: String {
        switch self {
        case .rounds:
            count += 1
            if count % 2 == 0 {
                return "/content/dam/ircc/documents/json/ee_rounds_123_en.json"
            } else {
                return "/content/dam/ircc/documents/json/ee_rounds_123_en.jsoan"
            }
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .rounds:
            return .get
        }
    }
    
    
}
