//
//  ApiClientProtocol.swift
//  RepoPop
//
//  Created by Angela Alves on 07/03/23.
//

import Foundation
import RxSwift

protocol ApiClientProtocol {
    func makeRequest<T: Decodable>(url: String, endpoint: Endpoint) -> Observable<T>
}
