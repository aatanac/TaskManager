//
//  API.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/13/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import Moya

class API {

    static let provider = MoyaProvider<Service>(plugins: [CredentialsPlugin { _ -> URLCredential? in
        return URLCredential(user: Service.username, password: Service.password, persistence: .none)
        }
    ])

    static func request<T:Codable>(target: Service, object:T.Type,_  completion: @escaping ((Result<T, ServiceError>) -> Void)) {

        self.provider.request(target) { (result) in
            switch result {
            case .success(let response):
                guard (200...300).contains(response.statusCode) else {
                    let error = ServiceError.responseError(data: response.data)
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
