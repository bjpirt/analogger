//
//  FilmRollDTO.swift
//  Analogger
//
//  Created by Ben Pirt on 02/10/2024.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct FilmRollDTO: Codable {
    let created: String
    let name: String
    let filmStock: FilmStockDTO
    let filmShots: [FilmShotDTO]
    let cameraAsa: Int16
    
    static func create(from filmRoll: FilmRoll) -> FilmRollDTO {
        return FilmRollDTO(
            created: filmRoll.created.formatted(Date.ISO8601FormatStyle()),
            name: filmRoll.name,
            filmStock: FilmStockDTO.create(from: filmRoll.filmStock),
            filmShots: filmRoll.sortedFilmShots.map({ FilmShotDTO.create(from: $0) }),
            cameraAsa: filmRoll.cameraAsa
        )
    }
    
    func json() -> Data {
        return try! JSONEncoder().encode(self)
    }
}

struct CameraDTO: Codable {
    let make: String
    let model: String
    
    static func create(from camera: Camera) -> CameraDTO {
        return CameraDTO(make: camera.make, model: camera.model)
    }
}

struct FilmStockDTO: Codable {
    let asa: Int16
    let make: String
    let type: String
    
    static func create(from filmStock: FilmStock) -> FilmStockDTO {
        return FilmStockDTO(asa: filmStock.asa, make: filmStock.make, type: filmStock.type)
    }
}

struct LensDTO: Codable {
    let focalLength: Int16
    let make: String
    let model: String
    
    static func create(from lens: Lens) -> LensDTO {
        return LensDTO(focalLength: lens.focalLength, make: lens.make, model: lens.model)
    }
}

struct FilmShotDTO: Codable {
    let lat: Double
    let lon: Double
    let timestamp: String
    let camera: CameraDTO
    let lens: LensDTO?
    let country: String?
    let region: String?
    let locality: String?
    let street: String?
    let locationName: String?
    let fstop: String?
    let shutterSpeed: String?
    let evCompensation: String
    
    static func create(from filmShot: FilmShot) -> FilmShotDTO {
        return FilmShotDTO(
            lat: filmShot.lat,
            lon: filmShot.lon,
            timestamp: filmShot.timestamp.formatted(Date.ISO8601FormatStyle()),
            camera: CameraDTO.create(from: filmShot.camera),
            lens: filmShot.lens != nil ? LensDTO.create(from: filmShot.lens!) : nil,
            country: filmShot.country,
            region: filmShot.region,
            locality: filmShot.locality,
            street: filmShot.street,
            locationName: filmShot.locationName,
            fstop: filmShot.fstop,
            shutterSpeed: filmShot.shutterSpeed,
            evCompensation: filmShot.evCompensation
        )
    }
}

struct JsonDocument: FileDocument, Transferable {
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .json) { log in
            log.json
        }
    }
    
    static var readableContentTypes: [UTType] { [.json] }
    var json: Data
    
    init(configuration: ReadConfiguration) throws {
        guard
            let data = configuration.file.regularFileContents
        else { throw NSError() }
        self.json = data
    }
    
    init(json: Data) {
        self.json = json
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: self.json)
    }
}
