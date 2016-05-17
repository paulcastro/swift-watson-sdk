import SwiftyJSON

public struct KnowledgeGraph {

    /// A hierarchy of categories for the given object.
    public let typeHierarchy: String

    public init(json: JSON) {
        typeHierarchy = json["typeHierarchy"].stringValue
    }
}
