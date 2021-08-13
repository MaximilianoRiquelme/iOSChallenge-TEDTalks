//
//  TalksController.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 05/08/2021.
//

import Foundation

typealias TalksResponse = (Result<[Talk], Error>) -> Void

protocol TalksController
{
    var talks: [Talk]? { get }
    var filteredTalks: [Talk]? { get set }
    //var talk: Talk?
    
    func loadAllTalks(completion: @escaping TalksResponse)
}

class TalksControllerImp : TalksController
{
    var talks: [Talk]? = []
    var filteredTalks: [Talk]? = []
    
    //Loads all talks into an array
    func loadAllTalks(completion: @escaping TalksResponse) {
        TalksDecoder.parseJsonToArray() {
            [weak self] (result) in
                DispatchQueue.main.async {
                    switch result
                    {
                        case .success(let talksDecoded):
                            self?.talks = talksDecoded
                            completion(result)
                        case .failure(_):
                            self?.talks = []
                            completion(result)
                    }
                }
        }
    }
    
    func filterTalks(filter: String, searchText: String)
    {
        switch filter {
        case "0":
            filteredTalks = talks?.filter({$0.description.prefix(searchText.count).lowercased() == searchText.lowercased()})
        case "1":
            filteredTalks = talks?.filter({$0.mainSpeaker.prefix(searchText.count).lowercased() == searchText.lowercased()})
        case "2":
            filteredTalks = talks?.filter({$0.name.prefix(searchText.count).lowercased() == searchText.lowercased()})
        case "3":
            filteredTalks = talks?.filter({$0.speakerOccupation.prefix(searchText.count).lowercased() == searchText.lowercased()})
        case "4":
            filteredTalks = talks?.filter({$0.tags.joined().prefix(searchText.count).lowercased() == searchText.lowercased()})
        case "5":
            filteredTalks = talks?.filter({$0.title.prefix(searchText.count).lowercased() == searchText.lowercased()})
        default:
            return
        }
    }
}
