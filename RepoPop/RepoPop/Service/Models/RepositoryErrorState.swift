//
//  RepositoryErrorState.swift
//  RepoPop
//
//  Created by Angela Alves on 10/08/22.
//

import Foundation

enum ErrorState: Swift.Error {
    case generic
    case repositoryNotFound
    case noConnection
    case badRequest
    case invalidData
}
