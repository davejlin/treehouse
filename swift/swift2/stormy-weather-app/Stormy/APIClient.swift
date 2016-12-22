//
//  APIClient.swift
//  Stormy
//
//  Created by Lin David, US-205 on 10/5/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

public let NETWORKING_ERROR_DOMAIN = "com.davejlin.Stormy.NetworkingError"
public let MISSING_HTTP_RESPONSE_ERROR: Int = 10

typealias JSON = [String:AnyObject]
typealias JSONTaskCompletion = (JSON?, NSHTTPURLResponse?, NSError?) -> Void
typealias JSONTask = NSURLSessionDataTask

enum APIResult<T> {
    case Success(T)
    case Failure(ErrorType)
}

protocol JSONDecodable {
    init?(json: JSON)
}

protocol EndpointProtocol {
    var baseURL: NSURL { get }
    var path: String { get }
    var request: NSURLRequest { get }
}

protocol APIClientProtocol {
    var configuration: NSURLSessionConfiguration { get }
    var session: NSURLSession { get }
    
    init(config: NSURLSessionConfiguration, APIKey: String)
    
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion) -> JSONTask
    func fetch<T: JSONDecodable>(request: NSURLRequest, parse: JSON -> T?, completion: APIResult<T> -> Void)
}

extension APIClientProtocol {
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion) -> JSONTask {
        
        let task = session.dataTaskWithRequest(request) {
            data, response, error in
            
            guard let HTTPResponse = response as? NSHTTPURLResponse else {
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                
                let error = NSError(domain: NETWORKING_ERROR_DOMAIN, code: MISSING_HTTP_RESPONSE_ERROR, userInfo: userInfo)
                completion(nil, nil, error)
                return
            }
            
            guard let data = data else {
                if let error = error {
                    completion(nil, HTTPResponse, error)
                }
                return
            }

            switch HTTPResponse.statusCode {
            case 200:
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSON
                    completion(json, HTTPResponse, nil)
                } catch let error as NSError {
                    completion(nil, HTTPResponse, error)
                }
            default: print("Received HTTP Response: \(HTTPResponse.statusCode) - not handled")
            }
        }
        
        return task
    }
    
    func fetch<T>(request: NSURLRequest, parse: JSON -> T?, completion: APIResult<T> -> Void) {
        let task = JSONTaskWithRequest(request) {
            json, response, error in
            
            guard let json = json else {
                if let error = error {
                    completion(.Failure(error))
                } else {
                    // TODO: Implement Error Handling
                }
                return
            }
            
            if let value = parse(json) {
                completion(.Success(value))
            } else {
                let error = NSError(domain: NETWORKING_ERROR_DOMAIN, code: MISSING_HTTP_RESPONSE_ERROR, userInfo: nil)
                completion(.Failure(error))
            }
            
        }
        
        task.resume()
    }
    
}