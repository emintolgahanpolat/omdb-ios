//
//  Bind.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 23.04.2021.
//

import Foundation


public class Observable<Type> {
    public typealias Observer = (_ observable: Observable<Type>) -> Void
    
    private var observers: [Observer]
    
    public var value: Type? {
        didSet {
            if let value = value {
                notifyObservers(value)
            }
        }
    }
    
    public init(_ value: Type? = nil) {
        self.value = value
        observers = []
    }
    
    public func bind(observer: @escaping Observer) {
        self.observers.append(observer)
    }
    
    private func notifyObservers(_ value: Type) {
        self.observers.forEach { [unowned self](observer) in
            observer(self)
        }
    }
}

