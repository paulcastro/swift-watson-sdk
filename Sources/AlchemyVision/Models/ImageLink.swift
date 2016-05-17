import SwiftyJSON

public struct ImageLink {

    /// The status of the request.
    public let status: String

    /// The URL of the requested source.
    public let url: String

    /// The URL of the primary image.
    public let image: String

    public init(json: JSON) {
        status = json["status"].stringValue
        url = json["url"].stringValue
        image = json["image"].stringValue
    }
}