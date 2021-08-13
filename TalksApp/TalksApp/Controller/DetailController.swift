//
//  DetailController.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 12/08/2021.
//

import Foundation

protocol DetailController
{
    var talk: Talk { get set }
    var title: String { get set }
    var views: String { get set }
    var publishedDate: String { get set }
    var name: String { get set }
    var description: String { get set }
    var tags: String { get set }
    var url: URL? { get set }
}

struct DetailControllerImp: DetailController
{
    var talk: Talk
    var title: String
    var views: String
    var publishedDate: String
    var name: String
    var description: String
    var tags: String
    var url: URL?
    
    init(talk: Talk)
    {
        self.talk = talk
        self.title = talk.title
        self.views = "# of views \(String(describing: talk.views))"
        self.publishedDate = "Published Date: \(String(describing: talk.publishedDate))"
        self.name = talk.name
        self.description = talk.description
        self.tags = "Tags: \(String(describing: talk.tags.description))"
        self.url = URL(string: talk.url)
    }
}
