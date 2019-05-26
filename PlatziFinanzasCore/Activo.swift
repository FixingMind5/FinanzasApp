import Foundation

public class ACTIVO {
    public var valorActivo: Float
    public var liquidez: Float
    public var productividad: Bool
    public var observaciones: String?
    
    public init(valorActivo: Float, liquidez: Float, productividad: Bool) {
        self.valorActivo = valorActivo
        self.liquidez = liquidez
        self.productividad = productividad
    }
}
