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
    var getRepositories: (_ url: String, _ endpoint: Endpoint) -> Observable<RepositoryResponse>
    var getPullRequests: (_ url: String, _ endpoint: Endpoint) -> Observable<[PullRequestResponseItem]>
}

extension RPService {
    static func live(_ apiClient: ApiClientProtocol = RPClient()) -> Self {
        .init { url, endpoint in
            apiClient.makeRequest(
                url: url,
                endpoint: endpoint
            )
        }
            getPullRequests: { url, endpoint in
                apiClient.makeRequest(
                    url: url,
                    endpoint: endpoint
                )
            }
    }
}
