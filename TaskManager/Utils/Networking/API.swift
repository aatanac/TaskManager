//
//  API.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/13/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import Moya
import Alamofire

private class NetworkManager: Alamofire.SessionManager {

    static let sharedManager: NetworkManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        // timestamp exists
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return NetworkManager(configuration: configuration)
    }()

}

class API {
    // used for all netwrking calls in
    static func request<T:Codable>(target: Service, object:T.Type,_  completion: @escaping ((Result<T, ServiceError>) -> Void)) {

        // endpoint is created to fetch clear url without appended timestamp
        let endPoint = Endpoint<Service>(url: URL(target: target).absoluteString, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
        let urlString = try? endPoint.urlRequest().url?.absoluteString
        let urlObject = UrlManager.createObject(urlString: urlString ?? nil) // removing double optional
        let timeStamp = UrlManager.fetchTimeStamp(for: urlObject?.urlString ?? "")

        // hc credenitals injected
        // injected date to url
        let provider = MoyaProvider<Service>(endpointClosure: { (target) -> Endpoint<Service> in
            // appending last timestamp for request
            let task = target.task.mergerParms(with: ["updatedAfterDate":"\(timeStamp)"])
            return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: task, httpHeaderFields: target.headers)
        },manager: NetworkManager.sharedManager, plugins: [CredentialsPlugin { _ -> URLCredential? in
            return URLCredential(user: Service.username, password: Service.password, persistence: .none)
            }
        ])

        provider.request(target) { (result) in

            switch result {
            case .success(let response):
                guard (200...300).contains(response.statusCode) else {
                    let error = ServiceError.parseError(data: response.data)
                    return completion(.failure(error))
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateManager.formatter)
                    let value = try decoder.decode(T.self, from: response.data)
                    print("URL: ", response.request?.url ?? "No url")

                    // saving url with timestamp
                    if let object = urlObject {
                        UrlManager.saveObject(object: object)
                    }
                    return completion(.success(value))
                } catch let error {
                    return completion(.failure(.error(error)))
                }

            case .failure(let error):
                return completion(.failure(.error(error)))

            }
        }
    }
}
