//
//  UIDatePicker+Rx.swift
//  RxCocoa
//
//  Created by Daniel Tartaglia on 5/31/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS)

    import RxSwift
    import UIKit

    public extension Reactive where Base: UIDatePicker {
        /// Reactive wrapper for `date` property.
        var date: ControlProperty<Date> {
            return value
        }

        /// Reactive wrapper for `date` property.
        var value: ControlProperty<Date> {
            return base.rx.controlPropertyWithDefaultEvents(
                getter: { datePicker in
                    datePicker.date
                }, setter: { datePicker, value in
                    datePicker.date = value
                }
            )
        }

        /// Reactive wrapper for `countDownDuration` property.
        var countDownDuration: ControlProperty<TimeInterval> {
            return base.rx.controlPropertyWithDefaultEvents(
                getter: { datePicker in
                    datePicker.countDownDuration
                }, setter: { datePicker, value in
                    datePicker.countDownDuration = value
                }
            )
        }
    }

#endif
