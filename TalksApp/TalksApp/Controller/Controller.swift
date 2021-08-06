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
    var tedTalks: [Talk]? { get }
    
    func loadTalks(completion: @escaping TalksResponse)
}

class TalksController : Controller
{
    var tedTalks: [Talk]? = []
    
    func loadTalks(completion: @escaping TalksResponse) {
        TalksDecoder.parseJsonToTalks() {
            [weak self] (result) in
                DispatchQueue.main.async {
                    switch result
                    {
                        case .success(let talksDecoded):
                            self?.tedTalks = talksDecoded
                            completion(result)
                        case .failure(_):
                            self?.tedTalks = []
                            completion(result)
                    }
                }
        }
    }
}
