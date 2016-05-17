import KituraNet
import SwiftyJSON
import Foundation

public enum Method: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

public struct QueryItem {

    private let name: String
    private let value: String
    
    private let unreservedCharacters = NSCharacterSet.init(charactersIn:
        "abcdefghijklmnopqrstuvwxyz" + "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "1234567890-._~")
    
    public var encoded: String {
        let name = self.name.addingPercentEncoding(withAllowedCharacters: unreservedCharacters)!
        let value = self.value.addingPercentEncoding(withAllowedCharacters: unreservedCharacters)!
        return "\(name)=\(value)"
    }
    
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

public class RestRequest {

    private let method: Method
    private let url: String
    private let acceptType: String?
    private let contentType: String?
    private let queryParameters: [QueryItem]?
    private let headerParameters: [String: String]?
    private let messageBody: NSData?
    private let username: String?
    private let password: String?
    
    private let domain = "com.ibm.swift.rest-kit"
    private let unreservedCharacters = NSCharacterSet.init(charactersIn:
        "abcdefghijklmnopqrstuvwxyz" + "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "1234567890-._~")

    public func response(callback: ClientRequestCallback) {
    
        // construct url with query parameters
        var url = self.url
        if let queryParameters = queryParameters {
            let pairs = queryParameters.map { item in item.encoded }
            "&".
            url += "?" + "&".join(pairs)
        }
        let urlComponents = NSURLComponents(string: self.url)!
        if let queryParameters = queryParameters where !queryParameters.isEmpty {
            urlComponents.queryItems = queryParameters
        }

        // construct headers
        var headers = [String: String]()
        
        // set the request's accept type
        if let acceptType = acceptType {
            headers["Accept"] = acceptType
        }

        // set the request's content type
        if let contentType = contentType {
            headers["Content-Type"] = contentType
        }

        // set the request's header parameters
        if let headerParameters = headerParameters {
            for (key, value) in headerParameters {
                headers[key] = value
            }
        }
        
        // verify required url components 
        guard let scheme = urlComponents.scheme else {
            print("Cannot execute request. Please add a scheme to the url (e.g. \"http://\").")
            return
        }
        guard let hostname = urlComponents.percentEncodedHost else {
            print("Cannot execute request. Please add a hostname to the url (e.g. \"www.ibm.com\").")
            return
        }
        guard let path = urlComponents.percentEncodedPath else {
            print("Cannot execute request. Path could not be determined from the url.")
            return
        }

        // construct client request options
        var options = [ClientRequestOptions]()
        options.append(.Method(method.rawValue))
        options.append(.Headers(headers))
        options.append(.Schema(scheme + "://"))
        options.append(.Hostname(hostname))
        if let query = urlComponents.query {
            let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: unreservedCharacters)!
            print(path + "?" + escapedQuery)
            options.append(.Path(path + "?" + escapedQuery))
        } else {
            options.append(.Path(path))
        }
        if let username = username {
            options.append(.Username(username))
        }
        if let password = password {
            options.append(.Password(password))
        }

        // construct and execute HTTP request
        Http.request(options, callback: callback).end()
    }

    public func responseJSON(callback: RestResult<JSON, NSError> -> Void) {

        self.response { r in
            guard let response = r where response.statusCode == HttpStatusCode.OK else {
                let failureReason = "Response status code was unacceptable: \(r?.statusCode)."
                let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
                let error = NSError(domain: self.domain, code: 0, userInfo: userInfo)
                callback(.Failure(error))
                return
            }

            do {
                let body = NSMutableData()
                try response.readAllData(into: body)
                let json = JSON(data: body)
                callback(.Success(json))
            } catch {
                let failureReason = "Could not parse response data."
                let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
                let error = NSError(domain: self.domain, code: 0, userInfo: userInfo)
                callback(.Failure(error))
                return
            }
        }
    }

    public init(
        method: Method,
        url: String,
        acceptType: String? = nil,
        contentType: String? = nil,
        queryParameters: [NSURLQueryItem]? = nil,
        headerParameters: [String: String]? = nil,
        messageBody: NSData? = nil,
        username: String? = nil,
        password: String? = nil)
    {
        self.method = method
        self.url = url
        self.acceptType = acceptType
        self.contentType = contentType
        self.queryParameters = queryParameters
        self.headerParameters = headerParameters
        self.messageBody = messageBody
        self.username = username
        self.password = password
    }
}
