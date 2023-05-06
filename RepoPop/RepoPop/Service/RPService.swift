//
//  RPService.swift
//  RepoPop
//
//  Created by Angela Alves on 07/03/23.
//

import Foundation
import RxSwift
import UIKit

struct RPService {
    var repositories: (_ url: String, _ endpoint: Endpoint) -> Observable<RepositoryResponse>
    var pullRequests: (_ url: String, _ endpoint: Endpoint) -> Observable<[PullRequestResponseItem]>
}

extension RPService {
    static func live(_ apiClient: ApiClientProtocol = RPClient()) -> Self {
        .init { url, endpoint in
            apiClient.makeRequest(
                url: url,
                endpoint: endpoint
            )
        } pullRequests: { url, endpoint in
            apiClient.makeRequest(
                url: url,
                endpoint: endpoint
            )
        }
    }
}
