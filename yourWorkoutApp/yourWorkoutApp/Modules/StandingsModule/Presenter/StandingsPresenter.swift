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
    var data: DataClass? {get set}
    var standings: [Standing]? {get set}
    
    func backButtonTapped()
}

class StandingsPresenter: StandingsViewOutput {
    var data: DataClass?
    var standings: [Standing]? {
        didSet{
            view?.reloadCollection()
        }
    }
    
    private var leagueId: String
    private var networkService: NetworkService
    private var router: RouterForLeaguesModule
    weak var view: StandingsViewInput?
    
    init(router: RouterForLeaguesModule, networkService: NetworkService, leagueId: String) {
        self.router = router
        self.networkService = networkService
        self.leagueId = leagueId
        loadStandings()
    }
    
    func backButtonTapped() {
        router.popVC()
    }
    
}

extension StandingsPresenter {
    private func loadStandings() {
        let standingsParam = "\(API.leagues)/\(leagueId)\(API.standings)"
        networkService.getRequest(type: DataStandings.self, urlString: API.urlString, param: standingsParam) { res in
            switch res {
            case .success(let data):
                self.data = data.data
                print(data.data)
                self.standings = data.data.standings
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
