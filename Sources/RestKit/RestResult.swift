import Foundation

public enum RestResult<Value, Error: ErrorProtocol> {
    case Success(Value)
    case Failure(Error)
}
