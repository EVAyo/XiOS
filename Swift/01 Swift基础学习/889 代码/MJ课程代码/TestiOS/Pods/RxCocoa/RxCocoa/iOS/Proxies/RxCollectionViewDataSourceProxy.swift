//
//  RxCollectionViewDataSourceProxy.swift
//  RxCocoa
//
//  Created by Krunoslav Zaher on 6/29/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    extension UICollectionView: HasDataSource {
        public typealias DataSource = UICollectionViewDataSource
    }

    fileprivate let collectionViewDataSourceNotSet = CollectionViewDataSourceNotSet()

    fileprivate final class CollectionViewDataSourceNotSet:
        NSObject,
        UICollectionViewDataSource
    {
        func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
            return 0
        }

        // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
        func collectionView(_: UICollectionView, cellForItemAt _: IndexPath) -> UICollectionViewCell {
            rxAbstractMethod(message: dataSourceNotSet)
        }
    }

    /// For more information take a look at `DelegateProxyType`.
    open class RxCollectionViewDataSourceProxy:
        DelegateProxy<UICollectionView, UICollectionViewDataSource>,
        DelegateProxyType,
        UICollectionViewDataSource
    {
        /// Typed parent object.
        public private(set) weak var collectionView: UICollectionView?

        /// - parameter collectionView: Parent object for delegate proxy.
        public init(collectionView: ParentObject) {
            self.collectionView = collectionView
            super.init(parentObject: collectionView, delegateProxy: RxCollectionViewDataSourceProxy.self)
        }

        // Register known implementations
        public static func registerKnownImplementations() {
            register { RxCollectionViewDataSourceProxy(collectionView: $0) }
        }

        private weak var _requiredMethodsDataSource: UICollectionViewDataSource? = collectionViewDataSourceNotSet

        // MARK: delegate

        /// Required delegate method implementation.
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return (_requiredMethodsDataSource ?? collectionViewDataSourceNotSet).collectionView(collectionView, numberOfItemsInSection: section)
        }

        /// Required delegate method implementation.
        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return (_requiredMethodsDataSource ?? collectionViewDataSourceNotSet).collectionView(collectionView, cellForItemAt: indexPath)
        }

        /// For more information take a look at `DelegateProxyType`.
        override open func setForwardToDelegate(_ forwardToDelegate: UICollectionViewDataSource?, retainDelegate: Bool) {
            _requiredMethodsDataSource = forwardToDelegate ?? collectionViewDataSourceNotSet
            super.setForwardToDelegate(forwardToDelegate, retainDelegate: retainDelegate)
        }
    }

#endif
