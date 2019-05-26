import Foundation

public typealias transactionHandler = ( (_ completed: Bool, _ confirmation: Date) -> Void)

public protocol extractValue {
    func extractValue(_ trans: transactions)
}

