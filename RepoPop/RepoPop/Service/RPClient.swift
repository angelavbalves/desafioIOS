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
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data else {
                        observer.onError(ErrorState.invalidData("Invalid Data"))
                        observer.onCompleted()
                        return
                    }
                    if let response = response as? HTTPURLResponse {
                        switch response.statusCode {
                            case 200...299:
                                do {
                                    let model = try JSONDecoder().decode(T.self, from: data)
                                    observer.onNext(model)
                                } catch {
                                    observer.onError(ErrorState.generic("Decoding Error"))
                                }
                            case 300...399:
                                observer.onError(ErrorState.generic("Redirect Error"))
                            case 400...499:
                                observer.onError(ErrorState.generic("Bad Request"))
                            case 500...599:
                                observer.onError(ErrorState.generic("Internal Server Error"))
                            default:
                                observer.onError(ErrorState.unrecognizedError("Unrecognized Error"))
                        }
                        observer.onCompleted()
                    }
                }
                task.resume()
            }
            return Disposables.create()
        }
    }
}
