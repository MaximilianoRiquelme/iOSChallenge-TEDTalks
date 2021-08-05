//
//  TalksController.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 05/08/2021.
//

import Foundation
protocol Controller
{
    func loadTalks()
}


class TalksController : Controller
{
    var tedTalks: [Talk]? = []
    
    static let instance = TalksController()
    
    init() {
    }
    
    func loadTalks() {
        TalksDecoderFacade.parseJsonToTalks()
        {
            [weak self] (result) in
            switch result
            {
                case .success(let talksDecoded):
                    self?.tedTalks = talksDecoded
                case .failure(_):
                    self?.tedTalks = []
                    
            }
        }
    }
}
