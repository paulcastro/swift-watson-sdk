import SwiftyJSON

public struct SceneText {

    /// The status of the request.
    public let status: String

    /// The URL of the requested image being analyzed.
    public let url: String

    /// The number of transactions charged for this request.
    public let totalTransactions: Int

    /// The aggregate of all identified lines of text in the image.
    public let sceneText: String

    /// The individual lines of text identified in the image.
    public let sceneTextLines: [SceneTextLine]

    public init(json: JSON) {
        status = json["status"].stringValue
        url = json["url"].stringValue
        totalTransactions = Int(json["totalTransactions"].stringValue)!
        sceneText = json["sceneText"].stringValue
        sceneTextLines = json["sceneTextLines"].arrayValue.map(SceneTextLine.init)
    }
}

public struct SceneTextLine {

    /// The likelihood that the identified text is correct.
    public let confidence: Double

    /// The region of the image that contains the identified text.
    public let region: Region

    /// The identified line of text.
    public let text: String

    /// The words of the identified line of text.
    public let words: [Word]

    public init(json: JSON) {
        confidence = json["confidence"].doubleValue
        region = Region(json: json["region"])
        text = json["text"].stringValue
        words = json["words"].arrayValue.map(Word.init)
    }
}

public struct Region {

    /// The height, in pixels, of the detected face.
    public let height: Int

    /// The width, in pixels, of the detected face.
    public let width: Int

    /// The coordinate of the left-most pixel of the detected face.
    public let x: Int

    /// The coordinate of the right-most pixel of the detected face.
    public let y: Int

    public init(json: JSON) {
        height = json["height"].intValue
        width = json["width"].intValue
        x = json["x"].intValue
        y = json["y"].intValue
    }
}

public struct Word {

    /// The likelihood that the identified word is correct.
    public let confidence: Double

    /// The region of the image that contains the identified word.
    public let region: Region

    /// The word of the identified line of text.
    public let text: String

    public init(json: JSON) {
        confidence = json["confidence"].doubleValue
        region = Region(json: json["region"])
        text = json["text"].stringValue
    }
}