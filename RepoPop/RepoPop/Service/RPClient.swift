//
//  RPClient.swift
//  RepoPop
//
//  Created by Angela Alves on 07/03/23.
//

import Foundation
import RxSwift

class RPClient: ApiClientProtocol {
    func makeRequest<T>(url: String, endpoint: Endpoint) -> Observable<T> where T: Decodable {
        Observable<T>.create { observer in
            var components = URLComponents(string: url)
            components?.path = endpoint.path
            components?.queryItems = endpoint.query
            if !endpoint.query.isEmpty {
                if var component = components {
                    component.query = component.query?.insertString("q=")
                    components = component
                }
            }
            let urlComponent = components?.url
            if let url = urlComponent {
                let request = URLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    guard let data = data else {
                        observer.onError(ErrorState.invalidData)
                        observer.onCompleted()
                        return
                    }
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(model)
                    } catch {
                        observer.onError(error)
                    }
                    observer.onCompleted()
                }
                task.resume()
            }
            return Disposables.create()
        }
    }
}
