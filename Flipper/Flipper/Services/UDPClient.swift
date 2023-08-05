//
//  UDPClient.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 3/28/21.
//

import Foundation

import Network

struct UDPClient {
    static let panels = 2
    static let colsPerPanel = 28
    static let dotsPerCol = 7
    
    private let connection: NWConnection
    private let maxPayload = panels * colsPerPanel

    private let udpQueue = DispatchQueue(label: "udpQueue", attributes: [], autoreleaseFrequency: .workItem)


    init(host: String, port: String) {
        let nwHost = NWEndpoint.Host(host)
        guard let nwPort = NWEndpoint.Port(port) else {
            fatalError("Invalid port defined.")
        }

        connection = NWConnection(host: nwHost, port: nwPort, using: .udp)
    }

    func start() {
        connection.start(queue: udpQueue)
    }

    func stop() {
        connection.cancel()
    }

    func send(_ dots: [Dot], completion: @escaping (Error?) -> Void) {
        let data = dots.toPayload(
            panels: UDPClient.panels,
            colsPerPanel: UDPClient.colsPerPanel,
            dotsPerCol: UDPClient.dotsPerCol
        )
        
        // for now, since we send all columns as a payload, make sure the numbers match
        guard data.count == maxPayload else {
            print("Error! Maximum payload would be exceeded when trying to send!")
            completion(UDPError.maxPayloadExceeded)
            return
        }
        
        connection.send(content: data, completion: .contentProcessed(completion))
    }
}

//// payload processed by the rover
//struct UDPPayload {
//    let values: [Int]
//
//    func toData() -> Data {
//        let uint8Values = values.map { UInt8($0) }
//        return Data(uint8Values)
//    }
//}

enum UDPError: Error {
    case maxPayloadExceeded
}

extension Array where Element : Dot {
    /// Translates a cartesian matrix layout represented by a one dimensional array
    /// to a column-based byte array of `UInt8`. This allows us to represent an entire column
    /// with a single byte.
    ///
    /// The resulting number of elements should be panels * columnsPerPanel
    func toPayload(panels: Int, colsPerPanel: Int, dotsPerCol: Int) -> [UInt8] {
        var byteArray = [UInt8]()
        
        for p in 0..<panels {
            for c in 0..<colsPerPanel {
                var colByte: UInt8 = 0
                for d in 0..<dotsPerCol {
                    let idx = d * colsPerPanel + c + (p*colsPerPanel*dotsPerCol)
                    let flipped: UInt8 = self[idx].flipped ? 1 : 0
                    colByte = colByte | (flipped << d)
                }
                
                byteArray.append(colByte)
            }
        }
        
        return byteArray
    }
}
