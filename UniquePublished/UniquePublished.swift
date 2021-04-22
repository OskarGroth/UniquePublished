//
//  UniquePublished.swift
//  UniquePublished
//
//  Created by Oskar Groth on 2021-04-22.
//  https://www.swiftbysundell.com/articles/accessing-a-swift-property-wrappers-enclosing-instance/

import Foundation
import Combine

@propertyWrapper
struct UniquePublished<Value> where Value: Equatable {
    private var storage: Value

    init(wrappedValue value: Value) {
        self.storage = value
    }
    
    static subscript<T: ObservableObject>(
        _enclosingInstance instance: T,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<T, Self>
    ) -> Value {
        get {
            instance[keyPath: storageKeyPath].storage
        }
        set {
            guard newValue != instance[keyPath: storageKeyPath].storage else { return }
            (instance.objectWillChange as? ObservableObjectPublisher)?.send()
            instance[keyPath: storageKeyPath].storage = newValue
        }
    }
    
    @available(*, unavailable, message: "@UniquePublished can only be applied to classes")
    var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }
    
}
