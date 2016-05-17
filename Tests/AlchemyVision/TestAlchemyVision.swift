import AlchemyVision

import Foundation
import XCTest

class TestAlchemyVision: XCTestCase {
    
    private let alchemyVision = AlchemyVision(apiKey: Credentials.alchemyAPIKey)

    override func setUp() {
        super.setUp()
    }

    func testGetRankedImageFaceTags() {
        
        let url = "https://www.whitehouse.gov/sites/whitehouse.gov/files/images/" +
                  "Administration/People/president_official_portrait_lores.jpg"
        let knowledgeGraph = true
        let failure = { (error: NSError) in print(error) }

        alchemyVision.getRankedImageFaceTags(
            url: url,
            knowledgeGraph: knowledgeGraph,
            failure: failure)
        {
            faceTags in
            print(faceTags)
        }
    }
}
