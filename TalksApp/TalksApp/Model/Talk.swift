//
//  Talk.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 03/08/2021.
//

import Foundation

struct Talk: Codable {
    
    let description: String
    let duration: UInt
    let event: String
    let filmDate: Int //Is it a date?
    let languages: UInt
    let mainSpeaker: String
    let name: String
    let numSpeaker: UInt
    let publishedDate: Int //Is it a date?
    let speakerOccupation: String
    let tags: [String]
    let title: String
    let url: String
    let views: UInt
    
    enum CodingKeys : String, CodingKey {
        case description, duration, event
        case filmDate = "film_date"
        case languages
        case mainSpeaker = "main_speaker"
        case name
        case numSpeaker = "num_speaker"
        case publishedDate = "published_date"
        case speakerOccupation = "speaker_occupation"
        case tags, title, url, views
    }
}


