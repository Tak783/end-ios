//
//  ListingsFeedViewController.swift
//  END-iOS
//
//  Created by Tak Mazarura on 14/08/2024.
//

import CoreFoundational
import CorePresentation
import ENDListingsFeature
import SnapKit
import UIKit

final class ListingsFeedViewController: UIViewController {
    var feedViewModel: ListingsFeedViewModelling?
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loadFeed()
    }
}

// MARK: - Set Up View
extension ListingsFeedViewController {
    private func setUpView() {
        setUpCollectionView()
        setUpViewConstraints()
        bindViewModelToView()
    }
    
    private func setUpViewConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindViewModelToView() {
        feedViewModel?.onLoadingStateChange = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.updateHUD(toShow: isLoading)
            }
        }

        feedViewModel?.onFeedLoadError = { _ in
            efficientPrint("Did fail to load feed")
        }

        feedViewModel?.onFeedLoadSuccess = { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.reloadCollectionView()
            }
        }
    }
}

// MARK: - Set Up Collection View
extension ListingsFeedViewController {
    private func setUpCollectionView() {
        setUpCollectionViewFlowLayout()
        registerCollectionViewCells()
        setUpCollectionViewDataSourceAndDelegate()
        view.addSubview(collectionView)
    }
    
    private func setUpCollectionViewFlowLayout() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: Self.collectionViewFlowLayout(forView: view)
        )
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(
            ListingCollectionViewCell.self,
            forCellWithReuseIdentifier: ListingCollectionViewCell.className
        )
    }
    
    private func setUpCollectionViewDataSourceAndDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}


// MARK: - Update View
extension ListingsFeedViewController {
    private func loadFeed() {
        feedViewModel?.loadFeed()
    }
    
    private func reloadCollectionView() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ListingsFeedViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return feedViewModel?.feedItemPresentaionModels.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListingCollectionViewCell.className,
            for: indexPath
        ) as? ListingCollectionViewCell else {
            return .init()
        }
        
        if let listing = feedViewModel?.feedItemPresentaionModels[indexPath.item] {
            cell.update(withListing: listing)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ListingsFeedViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        efficientPrint("Did select item at index path \(indexPath)")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListingsFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        return layout.itemSize
    }
}

// MARK: - Factory Methods
extension ListingsFeedViewController {
    private static func collectionViewFlowLayout(forView view: UIView) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        
        let itemWidth = (view.frame.width - Layout.regularMargin * 2 - 10) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 300)
        
        layout.sectionInset = UIEdgeInsets(
            top: .zero,
            left: Layout.regularMargin,
            bottom: .zero,
            right: Layout.regularMargin
        )
        
        return layout
    }
}
