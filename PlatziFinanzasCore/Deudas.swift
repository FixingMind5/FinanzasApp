import Foundation

public class DEUDA {
    public var saldoDeuda: Float
    public var cuota: Float
    public var tasa: Float
    public var beneficio: Bool
    public var observaciones: String?
     
    public init(saldoDeuda: Float, cuota: Float, tasa: Float, beneficio: Bool) {
        self.saldoDeuda = saldoDeuda
        self.cuota = cuota
        self.tasa = tasa
        self.beneficio = beneficio
    }
}
