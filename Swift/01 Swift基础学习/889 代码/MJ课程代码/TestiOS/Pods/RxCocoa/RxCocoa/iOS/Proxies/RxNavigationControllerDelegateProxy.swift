//
//  RxNavigationControllerDelegateProxy.swift
//  RxCocoa
//
//  Created by Diogo on 13/04/17.
//  Copyright © 2017 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    extension UINavigationController: HasDelegate {
        public typealias Delegate = UINavigationControllerDelegate
    }

    /// For more information take a look at `DelegateProxyType`.
    open class RxNavigationControllerDelegateProxy:
        DelegateProxy<UINavigationController, UINavigationControllerDelegate>,
        DelegateProxyType,
        UINavigationControllerDelegate
    {
        /// Typed parent object.
        public private(set) weak var navigationController: UINavigationController?

        /// - parameter navigationController: Parent object for delegate proxy.
        public init(navigationController: ParentObject) {
            self.navigationController = navigationController
            super.init(parentObject: navigationController, delegateProxy: RxNavigationControllerDelegateProxy.self)
        }

        // Register known implementations
        public static func registerKnownImplementations() {
            register { RxNavigationControllerDelegateProxy(navigationController: $0) }
        }
    }
#endif
