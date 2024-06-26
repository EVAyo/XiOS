//
//  NSControl+Rx.swift
//  RxCocoa
//
//  Created by Krunoslav Zaher on 5/31/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(macOS)

    import Cocoa
    import RxSwift

    private var rx_value_key: UInt8 = 0
    private var rx_control_events_key: UInt8 = 0

    public extension Reactive where Base: NSControl {
        /// Reactive wrapper for control event.
        var controlEvent: ControlEvent<Void> {
            MainScheduler.ensureRunningOnMainThread()

            let source = lazyInstanceObservable(&rx_control_events_key) { () -> Observable<Void> in
                Observable.create { [weak control = self.base] observer in
                    MainScheduler.ensureRunningOnMainThread()

                    guard let control = control else {
                        observer.on(.completed)
                        return Disposables.create()
                    }

                    let observer = ControlTarget(control: control) { _ in
                        observer.on(.next(()))
                    }

                    return observer
                }
                .takeUntil(self.deallocated)
                .share()
            }

            return ControlEvent(events: source)
        }

        /// Creates a `ControlProperty` that is triggered by target/action pattern value updates.
        ///
        /// - parameter getter: Property value getter.
        /// - parameter setter: Property value setter.
        func controlProperty<T>(
            getter: @escaping (Base) -> T,
            setter: @escaping (Base, T) -> Void
        ) -> ControlProperty<T> {
            MainScheduler.ensureRunningOnMainThread()

            let source = base.rx.lazyInstanceObservable(&rx_value_key) { () -> Observable<Void> in
                Observable.create { [weak weakControl = self.base] (observer: AnyObserver<Void>) in
                    guard let control = weakControl else {
                        observer.on(.completed)
                        return Disposables.create()
                    }

                    observer.on(.next(()))

                    let observer = ControlTarget(control: control) { _ in
                        if weakControl != nil {
                            observer.on(.next(()))
                        }
                    }

                    return observer
                }
                .takeUntil(self.deallocated)
                .share(replay: 1, scope: .whileConnected)
            }
            .flatMap { [weak base] _ -> Observable<T> in
                guard let control = base else { return Observable.empty() }
                return Observable.just(getter(control))
            }

            let bindingObserver = Binder(base, binding: setter)

            return ControlProperty(values: source, valueSink: bindingObserver)
        }

        /// Bindable sink for `enabled` property.
        var isEnabled: Binder<Bool> {
            return Binder(base) { owner, value in
                owner.isEnabled = value
            }
        }
    }

#endif
