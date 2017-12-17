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
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return NetworkManager(configuration: configuration)
    }()

}

class API {

    static func request<T:Codable>(target: Service, object:T.Type,_  completion: @escaping ((Result<T, ServiceError>) -> Void)) {

        let provider = MoyaProvider<Service>(manager: NetworkManager.sharedManager, plugins: [CredentialsPlugin { _ -> URLCredential? in
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
                    let value = try decoder.decode(T.self, from: response.data)
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
