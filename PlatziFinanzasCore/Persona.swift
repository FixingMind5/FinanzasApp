import Foundation

public protocol addActivo {
    func addActivo(_ activo: ACTIVO)
}

public protocol addAhorro {
    func addAhorro(ahorro: AHORRO)
}

public protocol addDeuda {
    func addDeuda(_ deuda: DEUDA)
}

public class PERSONA {
    public var name: String
    public var lastName: String
    public var ingresoNeto: Float {
        return cuenta?.ingresos.reduce(0.0, { $0 + $1.transValue } ) ?? 0
    }
    public var deudaConsumo: Float {
        return cuenta?.deudas.reduce(0.0, { $0 + $1.transValue } ) ?? 0
    }
    public var totalAhorro: Float {
        return ahorros.reduce(0.0, { $0 + $1.valorAhorro })
    }
    
    public var porcentajeDeuda: Float {
        return ingresoNeto / deudaConsumo
    }
    public var porcentajeAhorro: Float {
        return totalAhorro / ingresoNeto
    }
    public var mesesRiesgo: Float {
        return totalAhorro / cuenta!.deudas.reduce(0.0, { $0 + $1.transValue })
    }
    
    public var cuenta: CUENTA?
    public weak var tarjeta: creditCard?
    
    public var activos: [ACTIVO] = []
    public var misDeudas: [DEUDA] = []
    public var ahorros: [AHORRO] = []
    
    public init(name: String, lastName: String) {
        self.name = name
        self.lastName = lastName
    }
}

extension PERSONA : addActivo {
    public func addActivo(_ activo: ACTIVO) {
        activos.append(activo)
    }
}

extension PERSONA : addDeuda {
    public func addDeuda(_ deuda: DEUDA) {
        misDeudas.append(deuda)
    }
}

extension PERSONA : addAhorro {
    public func addAhorro(ahorro: AHORRO) {
        ahorros.append(ahorro)
    }
}
