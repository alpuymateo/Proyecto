//
//  SingletonModel.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 30/7/21.
//

import Foundation
class Singleton {
    var session_id: String!
    /// The static field that controls the access to the singleton instance.
    ///
    /// This implementation let you extend the Singleton class while keeping
    /// just one instance of each subclass around.
    static var shared: Singleton = {
        let instance = Singleton()
        // ... configure the instance
        // ...
        return instance
    }()

    /// The Singleton's initializer should always be private to prevent direct
    /// construction calls with the `new` operator.
    private init() {}


}
