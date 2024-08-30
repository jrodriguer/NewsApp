//
//  Log.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 30/8/24.
//

import Foundation
import SwiftyBeaver

class Log {
    static let write: SwiftyBeaver.Type = {
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss$d $N.$F():$l $L: $M"
        console.levelString.verbose = "🗣 VERBOSE"
        console.levelString.debug   = "🐛 DEBUG"
        console.levelString.info    = "ℹ️ INFO"
        console.levelString.warning = "⚠️ WARNING"
        console.levelString.error   = "🛑 ERROR"
        let swiftyBeaver = SwiftyBeaver.self
        swiftyBeaver.addDestination(console)
        
        return swiftyBeaver
    }()
    
    static func info<T>(tag: T, message: String) {
        write.info(String(describing: tag.self) + ": " + message)
    }
    
    static func error<T>(tag: T, message: String) {
        write.error(String(describing: tag.self) + ": " + message)
    }
    
    static func warning<T>(tag: T, message: String) {
        write.warning(String(describing: tag.self) + ": " + message)
    }
    
    static func debug<T>(tag: T, message: String) {
        write.debug(String(describing: tag.self) + ": " + message)
    }
    
    static func error<T>(tag: T, message: String, error: Error?) {
        write.error(String(describing: tag.self) + ": " + message)
    }
    
    static func verbose(_ message: String) {
        write.verbose(message)
    }
    
    private init() { }
}
