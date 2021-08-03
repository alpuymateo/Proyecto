//
//  SingletonModel.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 30/7/21.
//

import Foundation
struct Settings {
    static var shared = Settings()
    var session_id: String?
    var categories: [Int] = [28,12,16,10751,36,10402,10749,35]
    
    func getSession() -> String?{
        return self.session_id
    }
    
    private init() { }
}
/// The static field that controls the access to the singleton instance.
///
/// This implementation let you extend the Singleton class while keeping
/// just one instance of each subclass around.


/// The Singleton's initializer should always be private to prevent direct
/// construction calls with the `new` operator.




