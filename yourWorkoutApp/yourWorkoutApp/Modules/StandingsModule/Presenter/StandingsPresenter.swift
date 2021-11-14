//
//  StandingsPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 15.11.2021.
//

import Foundation

protocol StandingsViewInput: AnyObject {
        func reloadCollection()
}

protocol StandingsViewOutput: AnyObject {
    var data: DataStandings? {get set}
    var standings: [Standing]? {get set}
    
}

class StandingsPresenter: StandingsViewOutput {
    var data: DataStandings?
    var standings: [Standing]? {
        didSet{
            view?.reloadCollection()
        }
    }
    
    private var leagueId: String
    private var networkService: NetworkService
    weak var view: StandingsViewInput?
    
    init(networkService: NetworkService, leagueId: String) {
        self.networkService = networkService
        self.leagueId = leagueId
        loadStandings()
    }
    
}

extension StandingsPresenter {
    private func loadStandings() {
        networkService.getRequest(type: DataStandings.self, urlString: API.urlString, param: API.leagues) { res in
            switch res {
            case .success(let data):
                self.data = data
                self.standings = data.data.standings
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
