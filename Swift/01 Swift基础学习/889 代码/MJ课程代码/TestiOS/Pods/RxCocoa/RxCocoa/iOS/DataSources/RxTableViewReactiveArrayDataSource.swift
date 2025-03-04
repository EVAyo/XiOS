//
//  RxTableViewReactiveArrayDataSource.swift
//  RxCocoa
//
//  Created by Krunoslav Zaher on 6/26/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    // objc monkey business
    class _RxTableViewReactiveArrayDataSource:
        NSObject,
        UITableViewDataSource
    {
        func numberOfSections(in _: UITableView) -> Int {
            return 1
        }

        func _tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
            return 0
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return _tableView(tableView, numberOfRowsInSection: section)
        }

        fileprivate func _tableView(_: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
            rxAbstractMethod()
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return _tableView(tableView, cellForRowAt: indexPath)
        }
    }

    class RxTableViewReactiveArrayDataSourceSequenceWrapper<Sequence: Swift.Sequence>:
        RxTableViewReactiveArrayDataSource<Sequence.Element>,
        RxTableViewDataSourceType
    {
        typealias Element = Sequence

        override init(cellFactory: @escaping CellFactory) {
            super.init(cellFactory: cellFactory)
        }

        func tableView(_ tableView: UITableView, observedEvent: Event<Sequence>) {
            Binder(self) { tableViewDataSource, sectionModels in
                let sections = Array(sectionModels)
                tableViewDataSource.tableView(tableView, observedElements: sections)
            }.on(observedEvent)
        }
    }

    // Please take a look at `DelegateProxyType.swift`
    class RxTableViewReactiveArrayDataSource<Element>:
        _RxTableViewReactiveArrayDataSource,
        SectionedViewDataSourceType
    {
        typealias CellFactory = (UITableView, Int, Element) -> UITableViewCell

        var itemModels: [Element]?

        func modelAtIndex(_ index: Int) -> Element? {
            return itemModels?[index]
        }

        func model(at indexPath: IndexPath) throws -> Any {
            precondition(indexPath.section == 0)
            guard let item = itemModels?[indexPath.item] else {
                throw RxCocoaError.itemsNotYetBound(object: self)
            }
            return item
        }

        let cellFactory: CellFactory

        init(cellFactory: @escaping CellFactory) {
            self.cellFactory = cellFactory
        }

        override func _tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
            return itemModels?.count ?? 0
        }

        override func _tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return cellFactory(tableView, indexPath.item, itemModels![indexPath.row])
        }

        // reactive

        func tableView(_ tableView: UITableView, observedElements: [Element]) {
            itemModels = observedElements

            tableView.reloadData()
        }
    }

#endif
