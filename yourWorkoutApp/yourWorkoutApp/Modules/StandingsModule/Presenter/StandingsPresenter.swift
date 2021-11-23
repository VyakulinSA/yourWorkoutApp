//
//  StandingsPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 15.11.2021.
//

import Foundation

enum Stats: String {
    case rank
    case wins
    case losses
}

protocol StandingsViewInput: AnyObject {
        func reloadCollection()
}

protocol StandingsViewOutput: AnyObject {
    var data: DataClass? {get set}
    var standings: [Standing]? {get set}
    
    func backButtonTapped()
    func getStat(from statArray: [Stat], needStat: Stats) -> Int? 
}

class StandingsPresenter: StandingsViewOutput {
    var data: DataClass?
    var standings: [Standing]? {
        didSet{
            view?.reloadCollection()
        }
    }
    
    private var leagueId: String
    private var networkService: NetworkServiceProtocol
    private var router: RouterForLeaguesModule
    weak var view: StandingsViewInput?
    
    init(router: RouterForLeaguesModule, networkService: NetworkServiceProtocol, leagueId: String) {
        self.router = router
        self.networkService = networkService
        self.leagueId = leagueId
        loadStandings()
    }
    
    func backButtonTapped() {
        router.popVC()
    }
    
    func getStat(from statArray: [Stat], needStat: Stats) -> Int? {
        let tuples = createStats(stat: statArray)
        let filtered = tuples.filter { (st, val) in
            st == needStat
        }
        return filtered.first?.1
        
    }
    
    private func createStats(stat: [Stat]) -> [(Stats?, Int?)] {
        let stats = stat.filter { st in
            st.name == "rank" || st.name == "wins" || st.name == "losses"
        }
        let mapStats = stats.map{(Stats(rawValue: $0.name), $0.value)}
        return mapStats
    }
    
}

extension StandingsPresenter {
    private func loadStandings() {
        let standingsParam = "\(API.leagues)/\(leagueId)\(API.standings)"
        networkService.getRequest(type: DataStandings.self, urlString: API.urlString, param: standingsParam) { res in
            switch res {
            case .success(let data):
                self.data = data.data
                self.standings = data.data.standings
            case .failure(let error):
                self.router.showMessageAlert(message: error.localizedDescription)
            }
        }
    }
}
