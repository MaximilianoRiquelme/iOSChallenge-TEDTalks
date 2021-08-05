//
//  TalksDecoderFacade.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 04/08/2021.
//

import Foundation

typealias TalksResponse = (Result<[Talk], Error>) -> Void

enum NetworkError: Error {
    case urlError
    case serverError
    case parsingError
}

protocol TalksDecoder {
    static func parseJsonToTalks(completion: @escaping TalksResponse)
}

class TalksDecoderFacade : TalksDecoder {
    
    static func parseJsonToTalks(completion: @escaping TalksResponse)
    {
        guard let url = URL(string: "https://gist.githubusercontent.com/gonzaloperretti/0e79c229a5de5bacdd07f402c1a3cefd/raw/975582a4389601caa90d21227446ef2838159176/tedTalks.json")
        else{
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            guard error == nil, let myResponse = response as? HTTPURLResponse, myResponse.statusCode == 200,
                  let myData = data
            else
            {
                completion(.failure(NetworkError.serverError))
                return
            }
            
            do
            {
                let talksDecoded = try JSONDecoder().decode([Talk].self, from: myData)
                completion(.success(talksDecoded))
            }
            catch
            {
                completion(.failure(NetworkError.parsingError))
            }
        }
        
        dataTask.resume()
    }
}
