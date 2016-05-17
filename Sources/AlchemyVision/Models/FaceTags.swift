import SwiftyJSON

public struct FaceTags {

    /// The status of the request.
    public let status: String

    /// The URL of the requested image being tagged.
    public let url: String

    /// The number of transactions charged for this request.
    public let totalTransactions: Int

    /// The faces recognized in the requested image.
    public let imageFaces: [ImageFace]

    public init(json: JSON) {
        status = json["status"].stringValue
        url = json["url"].stringValue
        totalTransactions = Int(json["totalTransactions"].stringValue)!
        imageFaces = json["imageFaces"].arrayValue.map(ImageFace.init)
    }
}

public struct ImageFace {

    /// The coordinate of the left-most pixel of the detected face.
    public let positionX: Int

    /// The coordinate of the top-most pixel of the detected face.
    public let positionY: Int

    /// The width, in pixels, of the detected face.
    public let width: Int

    /// The height, in pixels, of the detected face.
    public let height: Int

    /// The gender of the detected face.
    public let gender: Gender

    /// The age of the detected face.
    public let age: Age

    /// The identity of the detected face.
    public let identity: Identity

    /// Information to disambiguate the detected face.
    public let disambiguated: Disambiguated

    public init(json: JSON) {
        positionX = json["positionX"].intValue
        positionY = json["positionY"].intValue
        width = json["width"].intValue
        height = json["height"].intValue
        gender = Gender(json: json["gender"])
        age = Age(json: json["age"])
        identity = Identity(json: json["identity"])
        disambiguated = Disambiguated(json: json["disambiguated"])
    }
}

public struct Gender {

    /// The gender of the detected face.
    public let gender: String

    /// The likelihood that this gender corresponds to the detected face.
    public let score: Double

    public init(json: JSON) {
        gender = json["gender"].stringValue
        score = json["score"].doubleValue
    }
}

public struct Age {

    /// The age range of the detected face.
    public let ageRange: String

    /// The likelihood that this age range corresponds to the detected face.
    public let score: Double

    public init(json: JSON) {
        ageRange = json["ageRange"].stringValue
        score = json["score"].doubleValue
    }
}

public struct Identity {

    /// The name of the detected face, if the face is identified as a known celebrity.
    public let name: String

    /// The likelihood that this name corresponds to the detected face.
    public let score: Double

    /// Metadata derived from the Alchemy knowledge graph.
    public let knowledgeGraph: KnowledgeGraph?

    public init(json: JSON) {
        name = json["name"].stringValue
        score = json["score"].doubleValue
        if json["knowledgeGraph"].exists() {
            knowledgeGraph = KnowledgeGraph(json: json["knowledgeGraph"])
        } else {
            knowledgeGraph = nil
        }
    }
}

public struct Disambiguated {

    /// The disambiguated entity name.
    public let name: String

    /// The disambiguated entity sub-type. Sub-types expose additional ontological mappings for a
    /// detected entity, such as identification of a person as a politician or athlete.
    public let subType: String

    /// The disambiguated entity website.
    public let website: String

    /// SameAs link to DBpedia for the disambiguated entity.
    public let dbpedia: String

    /// SameAs link to YAGO for the disambiguated entity.
    public let yago: String

    /// SameAs link to OpenCyc for the disambiguated entity.
    public let opencyc: String

    /// SameAs link to UMBEL for the disambiguated entity.
    public let umbel: String

    /// SameAs link to Freebase for the disambiguated entity.
    public let freebase: String

    /// SameAs link to MusicBrainz for the disambiguated entity.
    public let crunchbase: String

    public init(json: JSON) {
        name = json["name"].stringValue
        subType = json["subType"].stringValue
        website = json["website"].stringValue
        dbpedia = json["dbpedia"].stringValue
        yago = json["yago"].stringValue
        opencyc = json["opencyc"].stringValue
        umbel = json["umbel"].stringValue
        freebase = json["freebase"].stringValue
        crunchbase = json["crunchbase"].stringValue
    }
}