import Foundation

public protocol debitTypes : transactions {
    var debitType: debitCategory { get }
}

public enum debitCategory : String {
    case ahorro = "Ahorros"
    case vivienda = "Vivienda"
    case transporte = "Pasajes"
    case ocio = "Ocio"
    case educacion = "Escuela"
    case necesidades = "Cuidado personal"
    case trabajo = "Trabajo"
}

public class DEBIT : debitTypes {
    public var transCategory: transactionCategory?
    public var debitType: debitCategory
    public var transName: String
    public var transValue: Float
    public var transDate: Date
    public var transValid: Bool?
    public var transHandler: transactionHandler?
    
    public init(transName: String,
         transValue: Float,
         transDate: Date,
         transValid: Bool,
         debitType: debitCategory
        ) {
        self.transName = transName
        self.transValue = transValue
        self.debitType = debitType
        self.transDate = transDate
        self.transValid = transValid
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.transHandler?(true, Date())
        }
    }
}

