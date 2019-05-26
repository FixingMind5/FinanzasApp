import Foundation

public protocol gainTypes : transactions {
    var gainType: gainCategory { get }
}

public enum gainCategory : String {
    case salary = "Sueldo"
    case bienes = "Cosas que tenemos"
    case deuda = "Deudas que tienen conmigo"
}

public class GAIN : gainTypes {
    public var transCategory: transactionCategory?
    public var gainType: gainCategory
    public var transName: String
    public var transValue: Float
    public var transDate: Date
    public var transValid: Bool?
    public var transHandler: transactionHandler?
    
    public init(
        transName: String,
        transValue: Float,
        transDate: Date,
        transValid: Bool,
        gainType: gainCategory
        ) {
        self.transName = transName
        self.transValue = transValue
        self.gainType = gainType
        self.transDate = transDate
        self.transValid = transValid
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.transHandler?(true, Date())
        }
    }
}

