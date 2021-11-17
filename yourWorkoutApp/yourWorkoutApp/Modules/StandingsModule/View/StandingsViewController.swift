//
//  StandingsViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 15.11.2021.
//

import UIKit

class StandingsViewController: YWMainContainerViewController, StandingsViewInput {
    
    var presenter: StandingsViewOutput
    
    init(presenter: StandingsViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }


}

extension StandingsViewController {
    
    private func configViews() {
        collectionView.register(StandingsCollectionViewCell.self, forCellWithReuseIdentifier: StandingsCollectionViewCell.reuseIdentifier)
        
        setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: nil, secondRightBarButtonName: nil, titleBarText: "STANDINGS")
        
        leftBarButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
        presenter.backButtonTapped()
    }
    
    func reloadCollection() {
        collectionView.reloadData()
        titleView.text = presenter.data?.name
    }
    
}

//MARK: config collections
extension StandingsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.standings?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StandingsCollectionViewCell.reuseIdentifier, for: indexPath) as? StandingsCollectionViewCell else {return UICollectionViewCell()}
        
        if let standing = presenter.standings?[indexPath.item] {
            let image = WebImageView()
            image.set(imgeURL: standing.team.logos[0].href)
            cell.setupCellItems(
                teamImage: image.image,
                teamAbbr: standing.team.abbreviation,
                teamName: standing.team.name,
                teamRank: presenter.getStat(from: standing.stats, needStat: .rank),
                teamWins: presenter.getStat(from: standing.stats, needStat: .wins),
                teamLosses: presenter.getStat(from: standing.stats, needStat: .losses)
            )
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 150)
    }
}
