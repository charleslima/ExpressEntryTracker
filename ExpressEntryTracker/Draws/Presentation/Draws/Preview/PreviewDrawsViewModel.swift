import API
import Utilities

struct PreviewDrawsViewModel: IDrawsViewModel {
    var state: ViewState<[Draw]>
    var filter: String? = nil
    var displayFilter: Bool { viewMode == .rounds }
    var filterOptions: [String?] = ["Canadian Experience Class", "STEM"]
    var viewMode: DrawsViewMode = .rounds
    
    private let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    static var draws = [
        Draw(
            drawNumber: "188",
            drawNumberURL: "https://www.canada.ca/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html?q=188",
            drawDate: "2021-05-20",
            drawDateFull: "May 20, 2021",
            drawName: "Canadian Experience Class",
            drawSize: "1,842",
            drawCRS: "397",
            drawCutOff: "April 24, 2021 at 12:09:24 UTC",
            drawDistributionAsOn: Date(),
            pool: [.init(range: .dd1, candidates: "1000"), .init(range: .dd2, candidates: "3299")]
        ),
        Draw(
            drawNumber: "123",
            drawNumberURL: "https://www.canada.ca/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html?q=123",
            drawDate: "2021-05-20",
            drawDateFull: "May 20, 2021",
            drawName: "Canadian Experience Class",
            drawSize: "1,842",
            drawCRS: "397",
            drawCutOff: "April 24, 2021 at 12:09:24 UTC",
            drawDistributionAsOn: Date(),
            pool: [.init(range: .dd1, candidates: "1000"), .init(range: .dd2, candidates: "3299")]
        ),
        Draw(
            drawNumber: "124",
            drawNumberURL: "https://www.canada.ca/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html?q=188",
            drawDate: "2021-05-20",
            drawDateFull: "May 20, 2021",
            drawName: "Canadian Experience Class",
            drawSize: "1,842",
            drawCRS: "397",
            drawCutOff: "April 24, 2021 at 12:09:24 UTC",
            drawDistributionAsOn: Date(),
            pool: [.init(range: .dd1, candidates: "1000"), .init(range: .dd2, candidates: "3299")]
        ),
        Draw(
            drawNumber: "125",
            drawNumberURL: "https://www.canada.ca/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html?q=123",
            drawDate: "2021-05-20",
            drawDateFull: "May 20, 2021",
            drawName: "Canadian Experience Class",
            drawSize: "1,842",
            drawCRS: "397",
            drawCutOff: "April 24, 2021 at 12:09:24 UTC",
            drawDistributionAsOn: Date(),
            pool: [.init(range: .dd1, candidates: "1000"), .init(range: .dd2, candidates: "3299")]
        ),
        Draw(
            drawNumber: "100",
            drawNumberURL: "https://www.canada.ca/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html?q=188",
            drawDate: "2021-05-20",
            drawDateFull: "May 20, 2021",
            drawName: "Canadian Experience Class",
            drawSize: "1,842",
            drawCRS: "397",
            drawCutOff: "April 24, 2021 at 12:09:24 UTC",
            drawDistributionAsOn: Date(),
            pool: [.init(range: .dd1, candidates: "1000"), .init(range: .dd2, candidates: "3299")]
        ),
        Draw(
            drawNumber: "111",
            drawNumberURL: "https://www.canada.ca/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html?q=123",
            drawDate: "2021-05-20",
            drawDateFull: "May 20, 2021",
            drawName: "Canadian Experience Class",
            drawSize: "1,842",
            drawCRS: "397",
            drawCutOff: "April 24, 2021 at 12:09:24 UTC",
            drawDistributionAsOn: Date(),
            pool: [.init(range: .dd1, candidates: "1000"), .init(range: .dd2, candidates: "3299")]
        )
    ]
    
    func fetch() async { }
    func refresh() async { }
    
    func poolTitle(date: Date) -> String {
        "CRS score distribution of candidates in the Express Entry pool as of \(dateFormatter.string(from: date))"
    }
    
    func history(for range: ScoreRange) -> PoolHistory {
        PreviewPoolDetailViewModel.poolHistory
    }
}
