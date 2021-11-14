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
        collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier)
        
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier, for: indexPath) as? ExerciseCollectionViewCell else {return UICollectionViewCell()}
        
        if let standing = presenter.standings?[indexPath.item] {
            let image = WebImageView()
            image.set(imgeURL: standing.team.logos[0].href)
            cell.setupCellItems(leagueImage: image.image, leagueAbbr: standing.team.abbreviation, leagueName: standing.team.name)
        }
        return cell
    }
}
