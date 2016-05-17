import SwiftyJSON

public struct ImageKeywords {
    
    /// The status of the request.
    public let status: String

    /// The URL of the requested image being tagged.
    public let url: String

    /// The number of transactions charged for this request.
    public let totalTransactions: Int

    /// Keywords for the given image.
    public let imageKeywords: [ImageKeyword]

    public init(json: JSON) {
        status = json["status"].stringValue
        url = json["url"].stringValue
        totalTransactions = Int(json["totalTransactions"].stringValue)!
        imageKeywords = json["imageKeywords"].arrayValue.map(ImageKeyword.init)
    }
}

public struct ImageKeyword {

    /// A keyword that is associated with the specified image.
    public let text: String

    /// The likelihood that this keyword corresponds to the image.
    public let score: Double
    
    /// Metadata derived from the Alchemy knowledge graph.
    public let knowledgeGraph: KnowledgeGraph?

    public init(json: JSON) {
        text = json["text"].stringValue
        score = Double(json["score"].stringValue)!
        if (json["knowledgeGraph"].exists()) {
            knowledgeGraph = KnowledgeGraph(json: json["knowledgeGraph"])
        } else {
            knowledgeGraph = nil
        }
    }
}