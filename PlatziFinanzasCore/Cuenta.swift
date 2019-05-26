import Foundation

public protocol flujoCaja {
    func flujoCaja(_ trans: transactionIs) throws -> Float
}

public class CUENTA {
    public var saldoCuenta: Float {
        didSet {
            print("Tenemos un nuevo valor", saldoCuenta)
        }
    }
    public var miFlujo: [transactions] = []
    public var ingresos: [GAIN] = []
    public var deudas: [DEBIT] = []
     
    public init(saldoCuenta: Float) {
        self.saldoCuenta = saldoCuenta
    }
}

extension CUENTA : flujoCaja {
    public func flujoCaja(_ trans: transactionIs) throws -> Float {
        
        switch trans {
        case .gain(let gName, let gValue, let gDate, let gValid, let gType):
            
            let gain = GAIN(
                transName: gName,
                transValue: gValue,
                transDate: gDate,
                transValid: gValid,
                gainType: gType
            )
            
            gain.transHandler = { (completed, confirmation) in
                gain.transDate = confirmation
                self.ingresos.append(gain)
                self.miFlujo.append(gain)
                self.saldoCuenta += gain.transValue
            }
            
            
        case .debit(let dName, let dValue, let dDate, let dValid, let dType):
            
            let debit = DEBIT(
                transName: dName,
                transValue: dValue,
                transDate: dDate,
                transValid: dValid,
                debitType: dType
            )
            
            debit.transHandler = { (completed, confirmation) in
                debit.transDate = confirmation
                self.deudas.append(debit)
                self.deudas.filter({ (transaction) -> Bool in
                    guard let transaction = transaction as? DEBIT else {
                        return false
                    }
                    return transaction.debitType == debitCategory.ocio
                })
                self.miFlujo.append(debit)
                self.saldoCuenta -= debit.transValue
            }
            
            
            if (saldoCuenta < 0) {
                print("saldo negativo")
                throw transactionExceptions.saldoNegativo
            }
        }
        
        return saldoCuenta
    }
}
