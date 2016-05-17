import RestKit
import KituraNet
import SwiftyJSON

import Foundation

public class AlchemyVision {

    private let apiKey: String
    private let serviceURL = "http://gateway-a.watsonplatform.net/calls"
    private let domain = "com.ibm.swift.alchemy-vision"

    public init(apiKey: String) {
        self.apiKey = apiKey
    }

    public func getRankedImageFaceTags(
        url: String,
        knowledgeGraph: Bool? = nil,
        failure: (NSError -> Void)? = nil,
        success: [FaceTags] -> Void)
    {
        // construct query parameters
        var queryParameters = [NSURLQueryItem]()
        queryParameters.append(NSURLQueryItem(name: "url", value: url))
        queryParameters.append(NSURLQueryItem(name: "apiKey", value: apiKey))
        queryParameters.append(NSURLQueryItem(name: "outputMode", value: "json"))
        if let knowledgeGraph = knowledgeGraph {
            if knowledgeGraph {
                queryParameters.append(NSURLQueryItem(name: "knowledgeGraph", value: "1"))
            } else {
                queryParameters.append(NSURLQueryItem(name: "knowledgeGraph", value: "0"))
            }
        }

        // construct REST request
        let request = RestRequest(
            method: .GET,
            url: serviceURL + "/url/URLGetRankedImageFaceTags",
            acceptType: "application/json",
            queryParameters: queryParameters
        )

        // execute REST request
        request.responseJSON { response in
            print(response)
            switch response {
            case .Success(let json): success(json.arrayValue.map(FaceTags.init))
            case .Failure(let error): failure?(error)
            }
        }
    }

    public func getImage(
        html: String,
        url: String,
        failure: (NSError -> Void)? = nil,
        success: [ImageLink] -> Void)
    {
        // construct query parameters
        var queryParameters = [NSURLQueryItem]()
        queryParameters.append(NSURLQueryItem(name: "html", value: html))
        queryParameters.append(NSURLQueryItem(name: "url", value: url))
        queryParameters.append(NSURLQueryItem(name: "apiKey", value: apiKey))
        queryParameters.append(NSURLQueryItem(name: "outputMode", value: "json"))

        // construct REST request
        let request = RestRequest(
            method: .GET,
            url: serviceURL + "/html/HTMLGetImage",
            acceptType: "application/json",
            queryParameters: queryParameters
        )

        // execute REST request
        request.responseJSON { response in
            switch response {
            case .Success(let json): success(json.arrayValue.map(ImageLink.init))
            case .Failure(let error): failure?(error)
            }
        }
    }

    public func getImage(
        url: String,
        failure: (NSError -> Void)? = nil,
        success: [ImageLink] -> Void)
    {
        // construct query parameters
        var queryParameters = [NSURLQueryItem]()
        queryParameters.append(NSURLQueryItem(name: "url", value: url))
        queryParameters.append(NSURLQueryItem(name: "apiKey", value: apiKey))
        queryParameters.append(NSURLQueryItem(name: "outputMode", value: "json"))

        // construct REST request
        let request = RestRequest(
            method: .GET,
            url: serviceURL + "/url/URLGetImage",
            acceptType: "application/json",
            queryParameters: queryParameters
        )

        // execute REST request
        request.responseJSON { response in
            switch response {
            case .Success(let json): success(json.arrayValue.map(ImageLink.init))
            case .Failure(let error): failure?(error)
            }
        }
    }

    public func getRankedImageKeywords(
        url: String,
        forceShowAll: Bool? = nil,
        knowledgeGraph: Bool? = nil,
        failure: (NSError -> Void)? = nil,
        success: ImageKeywords -> Void)
    {
        // construct query parameters
        var queryParameters = [NSURLQueryItem]()
        queryParameters.append(NSURLQueryItem(name: "url", value: url))
        queryParameters.append(NSURLQueryItem(name: "apiKey", value: apiKey))
        queryParameters.append(NSURLQueryItem(name: "outputMode", value: "json"))
        if let forceShowAll = forceShowAll {
            if forceShowAll {
                queryParameters.append(NSURLQueryItem(name: "forceShowAll", value: "1"))
            } else {
                queryParameters.append(NSURLQueryItem(name: "forceShowAll", value: "0"))
            }
        }
        if let knowledgeGraph = knowledgeGraph {
            if knowledgeGraph {
                queryParameters.append(NSURLQueryItem(name: "knowledgeGraph", value: "1"))
            } else {
                queryParameters.append(NSURLQueryItem(name: "knowledgeGraph", value: "0"))
            }
        }

        // construct REST request
        let request = RestRequest(
            method: .GET,
            url: serviceURL + "/url/URLGetRankedImageKeywords",
            acceptType: "application/json",
            queryParameters: queryParameters
        )

        // execute REST request
        request.responseJSON { response in
            switch response {
            case .Success(let json): success(ImageKeywords(json: json))
            case .Failure(let error): failure?(error)
            }
        }
    }

    public func getRankedImageSceneText(
        url: String,
        failure: (NSError -> Void)? = nil,
        success: [SceneText] -> Void)
    {
        // construct query parameters
        var queryParameters = [NSURLQueryItem]()
        queryParameters.append(NSURLQueryItem(name: "url", value: url))
        queryParameters.append(NSURLQueryItem(name: "apiKey", value: apiKey))
        queryParameters.append(NSURLQueryItem(name: "outputMode", value: "json"))

        // construct REST request
        let request = RestRequest(
            method: .GET,
            url: serviceURL + "/url/URLGetRankedImageKeywords",
            acceptType: "application/json",
            queryParameters: queryParameters
        )

        // execute REST requeset
        request.responseJSON { response in
            switch response {
            case .Success(let json): success(json.arrayValue.map(SceneText.init))
            case .Failure(let error): failure?(error)
            }
        }
    }
}
