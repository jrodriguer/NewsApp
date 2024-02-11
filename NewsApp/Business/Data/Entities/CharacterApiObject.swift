//
//  CharacterApiObject.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 11/2/24.
//

import Foundation

struct RickAndMortyListApiObject<T: Codable>: Codable {
    var info: RickAndMortyInfo
    var results: [T]
}

struct RickAndMortyInfo: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

struct CharacterApiObject: Codable, Identifiable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String?
    var gender: String
    var origin: Location
    var location: Location
    var image: URL
    var episode: [URL]
    var url: URL
    var created: Date
    
    struct Location: Codable {
        var name: String
        var url: URL
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location, image, episode, url, created
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(String.self, forKey: .status)
        species = try container.decode(String.self, forKey: .species)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        gender = try container.decode(String.self, forKey: .gender)
        origin = try container.decode(Location.self, forKey: .origin)
        location = try container.decode(Location.self, forKey: .location)
        image = try container.decode(URL.self, forKey: .image)
        episode = try container.decode([URL].self, forKey: .episode)
        url = try container.decode(URL.self, forKey: .url)
        created = try container.decode(Date.self, forKey: .created)
    }

}
