//
//  LeaguesPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 14.11.2021.
//

import Foundation

protocol LeaguesViewInput: AnyObject {
    func reloadCollection()
}

protocol LeaguesViewOutput: AnyObject {
    var leagues: [Datum]? {get set}
    
    func startMenuButtonTapped()
    
    func didSelectLeague(item: Int)
    
}

class LeaguesPresenter: LeaguesViewOutput {
    private var networkService: NetworkServiceProtocol
    private var router: RouterForLeaguesModule
    weak var view: LeaguesViewInput?
    
    var leagues: [Datum]? {
        didSet{
            view?.reloadCollection()
        }
    }
    
    init(router: RouterForLeaguesModule, networkService: NetworkServiceProtocol) {
        self.router = router
        self.networkService = networkService
        loadLeagues()
    }
    
}

extension LeaguesPresenter {
    private func loadLeagues() {
        networkService.getRequest(type: Leagues.self, urlString: API.urlString, param: API.leagues) { res in
            switch res {
            case .success(let legues):
                self.leagues = legues.data
            case .failure(let error):
                self.router.showMessageAlert(message: error.localizedDescription)
            }
        }
    }
}

extension LeaguesPresenter {
    func startMenuButtonTapped() {
        router.initialViewController()
    }
    
    func didSelectLeague(item: Int) {
        guard let id = leagues?[item].id else {return}
        router.showStandingsViewController(leagueId: id)
    }
}
