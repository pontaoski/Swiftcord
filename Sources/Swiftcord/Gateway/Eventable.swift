//
//  Eventer.swift
//  Swiftcord
//
//  Created by Alejandro Alonso
//  Copyright © 2017 Alejandro Alonso. All rights reserved.
//

/// Create a nifty Event Emitter in Swift
public protocol Eventable: AnyObject {

    /// Event Listeners. For a better experience, use `ListenerAdapter`
    var listeners: [Event: [(Any) -> Void]] { get set }

    /// Event listeners with `ListenerAdapter1`.
    var listenerAdaptors: [ListenerAdapter] { get set }

    /**
     - parameter event: Event to listen for
     */
    func on(_ event: Event, do function: @escaping (Any) -> Void) -> Int

    /**
     - parameter event: Event to emit
     - parameter data: Array of stuff to emit listener with
     */
    func emit(_ event: Event, with data: Any)
}

extension Eventable {

    /**
     Listens for eventName

     - parameter event: Event to listen for
     */
    @discardableResult
    public func on(_ event: Event, do function: @escaping (Any) -> Void) -> Int {
        guard self.listeners[event] != nil else {
            self.listeners[event] = [function]
            return 0
        }

        self.listeners[event]!.append(function)

        return self.listeners[event]!.count - 1
    }

    /**
     Emits all listeners for eventName

     - parameter event: Event to emit
     - parameter data: Stuff to emit listener with
     */
    public func emit(_ event: Event, with data: Any = ()) {
        guard let listeners = self.listeners[event] else { return }

        for listener in listeners {
            listener(data)
        }
    }
}
