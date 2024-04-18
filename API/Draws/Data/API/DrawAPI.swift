//
//  DrawAPI.swift
//  API
//
//  Created by Charles Lima on 2024-04-17.
//

protocol IDrawAPI {
    func draws() async throws -> [InboundDraw]
}

class DrawAPI: IDrawAPI {
    
    let client: IAPIClient
    
    init(client: IAPIClient = APIClient()) {
        self.client = client
    }
    
    func draws() async throws -> [InboundDraw] {
        let response: InboundDrawResponse = try await client.request(endPoint: DrawEndpoint.rounds)
        return response.rounds
    }
}
