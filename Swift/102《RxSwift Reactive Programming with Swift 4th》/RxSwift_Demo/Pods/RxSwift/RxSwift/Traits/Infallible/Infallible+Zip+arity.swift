// This file is autogenerated. Take a look at `Preprocessor` target in RxSwift project
//
//  Infallible+Zip+arity.swift
//  RxSwift
//
//  Created by Shai Mishali on 27/8/20.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

// MARK: - Zip

// 2
public extension InfallibleType {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2>(_ source1: Infallible<E1>, _ source2: Infallible<E2>, resultSelector: @escaping (E1, E2) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(
            Observable.zip(source1.asObservable(), source2.asObservable(), resultSelector: resultSelector)
        )
    }
}

// 3
public extension InfallibleType {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3>(_ source1: Infallible<E1>, _ source2: Infallible<E2>, _ source3: Infallible<E3>, resultSelector: @escaping (E1, E2, E3) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(
            Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), resultSelector: resultSelector)
        )
    }
}

// 4
public extension InfallibleType {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4>(_ source1: Infallible<E1>, _ source2: Infallible<E2>, _ source3: Infallible<E3>, _ source4: Infallible<E4>, resultSelector: @escaping (E1, E2, E3, E4) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(
            Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), resultSelector: resultSelector)
        )
    }
}

// 5
public extension InfallibleType {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5>(_ source1: Infallible<E1>, _ source2: Infallible<E2>, _ source3: Infallible<E3>, _ source4: Infallible<E4>, _ source5: Infallible<E5>, resultSelector: @escaping (E1, E2, E3, E4, E5) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(
            Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), resultSelector: resultSelector)
        )
    }
}

// 6
public extension InfallibleType {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6>(_ source1: Infallible<E1>, _ source2: Infallible<E2>, _ source3: Infallible<E3>, _ source4: Infallible<E4>, _ source5: Infallible<E5>, _ source6: Infallible<E6>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(
            Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), resultSelector: resultSelector)
        )
    }
}

// 7
public extension InfallibleType {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6, E7>(_ source1: Infallible<E1>, _ source2: Infallible<E2>, _ source3: Infallible<E3>, _ source4: Infallible<E4>, _ source5: Infallible<E5>, _ source6: Infallible<E6>, _ source7: Infallible<E7>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6, E7) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(
            Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(), resultSelector: resultSelector)
        )
    }
}

// 8
public extension InfallibleType {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    static func zip<E1, E2, E3, E4, E5, E6, E7, E8>(_ source1: Infallible<E1>, _ source2: Infallible<E2>, _ source3: Infallible<E3>, _ source4: Infallible<E4>, _ source5: Infallible<E5>, _ source6: Infallible<E6>, _ source7: Infallible<E7>, _ source8: Infallible<E8>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6, E7, E8) throws -> Element)
        -> Infallible<Element>
    {
        Infallible(
            Observable.zip(source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(), source8.asObservable(), resultSelector: resultSelector)
        )
    }
}
