//
//  Task.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/2/25.
//

import Foundation

extension Task where Failure == Never, Success == Void {
    /// A convenience initializer for Task that takes a failure closure.
    /// - Parameter priority: The priority of a task.
    /// - Parameter operation: escaping Void.
    /// - Parameter catch: failure clousure.
    init(priority: TaskPriority? = nil, operation: @escaping () async throws -> Void, `catch`: @escaping (Error) -> Void) {
        self.init(priority: priority) {
            do {
                _ = try await operation()
            } catch {
                `catch`(error)
            }
        }
    }
}
