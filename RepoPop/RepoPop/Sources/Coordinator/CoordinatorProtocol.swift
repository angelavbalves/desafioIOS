//
//  CoordinatorProtocol.swift
//  RepoPop
//
//  Created by Angela Alves on 07/03/23.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var navController: UINavigationController? { get }
    var childCoordinator: [CoordinatorProtocol] { get set }
    func start()
}
