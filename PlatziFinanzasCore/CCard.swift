import Foundation

public protocol allCreditCards {
   var numberCard: UInt64 { get }
   var cvv: Int { get }
   var propietario: PERSONA { get }
   var expireDate: Date { get }
   var cutDate: Date { get }
   var payDate: Date { get }
}

public class creditCard : allCreditCards {
    public var numberCard: UInt64
    public var cvv: Int
    public var propietario: PERSONA
    public var expireDate: Date
    public var cutDate: Date
    public var payDate: Date
    
    public init(
        numberCard: UInt64,
        cvv: Int,
        propietario: PERSONA,
        expireDate: Date,
        cutDate: Date,
        payDate: Date
        ) {
        self.numberCard = numberCard
        self.cvv = cvv
        self.propietario = propietario
        self.expireDate = expireDate
        self.cutDate = cutDate
        self.payDate = payDate
    }
}

