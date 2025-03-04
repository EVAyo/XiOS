//
//  UIBarButtonItem+Rx.swift
//  RxCocoa
//
//  Created by Daniel Tartaglia on 5/31/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    fileprivate var rx_tap_key: UInt8 = 0

    public extension Reactive where Base: UIBarButtonItem {
        /// Bindable sink for `enabled` property.
        var isEnabled: Binder<Bool> {
            return Binder(base) { element, value in
                element.isEnabled = value
            }
        }

        /// Bindable sink for `title` property.
        var title: Binder<String> {
            return Binder(base) { element, value in
                element.title = value
            }
        }

        /// Reactive wrapper for target action pattern on `self`.
        var tap: ControlEvent<Void> {
            let source = lazyInstanceObservable(&rx_tap_key) { () -> Observable<Void> in
                Observable.create { [weak control = self.base] observer in
                    guard let control = control else {
                        observer.on(.completed)
                        return Disposables.create()
                    }
                    let target = BarButtonItemTarget(barButtonItem: control) {
                        observer.on(.next(()))
                    }
                    return target
                }
                .takeUntil(self.deallocated)
                .share()
            }

            return ControlEvent(events: source)
        }
    }

    @objc
    final class BarButtonItemTarget: RxTarget {
        typealias Callback = () -> Void

        weak var barButtonItem: UIBarButtonItem?
        var callback: Callback!

        init(barButtonItem: UIBarButtonItem, callback: @escaping () -> Void) {
            self.barButtonItem = barButtonItem
            self.callback = callback
            super.init()
            barButtonItem.target = self
            barButtonItem.action = #selector(BarButtonItemTarget.action(_:))
        }

        override func dispose() {
            super.dispose()
            #if DEBUG
                MainScheduler.ensureRunningOnMainThread()
            #endif

            barButtonItem?.target = nil
            barButtonItem?.action = nil

            callback = nil
        }

        @objc func action(_: AnyObject) {
            callback()
        }
    }

#endif
