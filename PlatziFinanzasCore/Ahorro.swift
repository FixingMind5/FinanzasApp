import Foundation

public protocol miAhorro {
    var valorAhorro: Float { get set }
    var nombreAhorro: String { get set }
}

public class AHORRO : miAhorro {
    public var valorAhorro: Float
    public var nombreAhorro: String
    
    public init(valorAhorro: Float, nombreAhorro: String) {
        self.valorAhorro = valorAhorro
        self.nombreAhorro = nombreAhorro
    }
}
