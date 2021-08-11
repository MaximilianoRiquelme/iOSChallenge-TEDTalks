//
//  TalksController.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 05/08/2021.
//

import Foundation

typealias TalksResponse = (Result<[Talk], Error>) -> Void

protocol Controller
{
    var talksArray: [Talk]? { get }
    var searchArray: [Talk]? { get set }
    
    func loadAllTalks(completion: @escaping TalksResponse)
}

class TalksController : Controller
{
    var talksArray: [Talk]? = []
    var searchArray: [Talk]? = []
    //var selectedTalk: Talk?
    
    static let instance = TalksController()
    
    init() {
    }
    
    //Loads all talks into an array
    func loadAllTalks(completion: @escaping TalksResponse) {
        concreteDecoder.parseJsonToArray() {
            [weak self] (result) in
                DispatchQueue.main.async {
                    switch result
                    {
                        case .success(let talksDecoded):
                            self?.talksArray = talksDecoded
                            completion(result)
                        case .failure(_):
                            self?.talksArray = []
                            completion(result)
                    }
                }
        }
    }
}
