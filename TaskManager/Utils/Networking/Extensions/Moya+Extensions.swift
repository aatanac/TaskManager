//
//  Moya+Extensions.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/18/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import Moya

extension Task {

    func mergerParms(with parameters: [String: Any], encoding: ParameterEncoding = URLEncoding.queryString) -> Task {
        switch self {
        case .requestParameters(parameters: let params, encoding: let encoding):
            var paramsInstance = parameters
            paramsInstance.merge(params, uniquingKeysWith: { (_, new) in new })
            return .requestParameters(parameters: paramsInstance, encoding: encoding)
        default:
            return .requestParameters(parameters: parameters, encoding: encoding)
        }
    }

}
