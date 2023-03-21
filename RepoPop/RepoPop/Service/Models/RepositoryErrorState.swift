//
//  RepositoryErrorState.swift
//  RepoPop
//
//  Created by Angela Alves on 10/08/22.
//

import Foundation

enum ErrorState: Swift.Error {
    case generic(_ description: String)
    case noConnection(_ description: String)
    case badRequest(_ description: String)
    case invalidData(_ description: String)
    case redirectError(_ description: String)
    case unrecognizedError(_ description: String)
}
