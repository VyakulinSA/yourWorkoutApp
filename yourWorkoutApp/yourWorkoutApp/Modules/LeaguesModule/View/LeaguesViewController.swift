//
//  LeaguesViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 14.11.2021.
//

import UIKit

class LeaguesViewController: YWMainContainerViewController, LeaguesViewInput {
    
    var presenter: LeaguesViewOutput
    
    init(presenter: LeaguesViewOutput) {
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

extension LeaguesViewController {
    
    private func configViews() {
        collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier)
        
        setupNavBarItems(leftBarButtonName: .burger, firstRightBarButtonName: nil, secondRightBarButtonName: nil, titleBarText: "LEAGUES")
        
        leftBarButton.addTarget(self, action: #selector(startMenuButtonTapped), for: .touchUpInside)
    }
    
    @objc func startMenuButtonTapped() {
        presenter.startMenuButtonTapped()
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
    
}

//MARK: config collections
extension LeaguesViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.leagues?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier, for: indexPath) as? ExerciseCollectionViewCell else {return UICollectionViewCell()}
        
        if let legue = presenter.leagues?[indexPath.item] {
            let image = WebImageView()
            image.set(imgeURL: legue.logos.light)
            cell.setupCellItems(leagueImage: image.image, leagueAbbr: legue.abbr, leagueName: legue.name)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectLeague(item: indexPath.item)
    }
}
