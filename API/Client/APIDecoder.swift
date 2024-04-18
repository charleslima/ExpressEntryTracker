public protocol APIDecoder {
    func decode<T: Decodable>(from data: Data) throws -> T
}

public struct V1Decoder: APIDecoder {
    
    let decoder: JSONDecoder
    
    public init() {
        decoder = JSONDecoder()
    }

    public func decode<T>(from data: Data) throws -> T where T : Decodable {
        try decoder.decode(T.self, from: data)
    }
}
