//
//  Endpoint.swift
//  RepoPop
//
//  Created by Angela Alves on 10/08/22.
//

import Foundation

protocol Endpoint {
    var host: String { get }
    var method: String { get }
    var path: String { get }
    var query: [URLQueryItem] { get }
}


