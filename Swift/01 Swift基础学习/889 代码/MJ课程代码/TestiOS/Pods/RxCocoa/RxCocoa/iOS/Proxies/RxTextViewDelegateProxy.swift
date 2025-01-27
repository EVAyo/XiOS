//
//  RxTextViewDelegateProxy.swift
//  RxCocoa
//
//  Created by Yuta ToKoRo on 7/19/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    /// For more information take a look at `DelegateProxyType`.
    open class RxTextViewDelegateProxy:
        RxScrollViewDelegateProxy,
        UITextViewDelegate
    {
        /// Typed parent object.
        public private(set) weak var textView: UITextView?

        /// - parameter textview: Parent object for delegate proxy.
        public init(textView: UITextView) {
            self.textView = textView
            super.init(scrollView: textView)
        }

        // MARK: delegate methods

        /// For more information take a look at `DelegateProxyType`.
        @objc open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            /**
              We've had some issues with observing text changes. This is here just in case we need the same hack in future and that
              we wouldn't need to change the public interface.
             */
            let forwardToDelegate = self.forwardToDelegate() as? UITextViewDelegate
            return forwardToDelegate?.textView?(textView,
                                                shouldChangeTextIn: range,
                                                replacementText: text) ?? true
        }
    }

#endif
