import API

class PreviewDrawsViewModel: IDrawsViewModel {
    var state: Result<[Draw], Error> = .failure(NSError())
    
    var draws: [Draw] = PreviewDrawsViewModel._draws
    
    static var _draws = [
        Draw(
            drawNumber: "188",
            drawNumberURL: "<a href='/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html?q=188'>188</a>",
            drawDate: "2021-05-20",
            drawDateFull: "May 20, 2021",
            drawName: "Canadian Experience Class",
            drawSize: "1,842",
            drawCRS: "397",
            drawCutOff: "April 24, 2021 at 12:09:24 UTC"
        ),
        Draw(
            drawNumber: "123",
            drawNumberURL: "<a href='/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html?q=188'>188</a>",
            drawDate: "2021-05-20",
            drawDateFull: "May 20, 2021",
            drawName: "Canadian Experience Class",
            drawSize: "1,842",
            drawCRS: "397",
            drawCutOff: "April 24, 2021 at 12:09:24 UTC"
        )
    ]
    
    func fetchDraws() async {
        
    }
}
