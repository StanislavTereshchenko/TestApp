//
//  InfoViewController.swift
//  TestApp
//
//  Created by Stanislav Tereshchenko on 26.04.2024.
//
import StoreKit
import UIKit

struct ReusableViewModel {
    var title : String
    var link : String
}

class InfoViewController: UIViewController {
    
    @IBOutlet weak var collectionViewForApp: UICollectionView!
    public var viewModel : [ReusableViewModel]?
    private let cellName = "InfoCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        loadViewModel()
        setupGradientBackground()
    }
    
    func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func loadViewModel() {
        viewModel = [ReusableViewModel(title: "\(NSLocalizedString("rateApp", comment: "").capitalized)", link: ""), ReusableViewModel(title: "\(NSLocalizedString("shareApp", comment: "").capitalized)", link: ""), ReusableViewModel(title: "\(NSLocalizedString("contactUs", comment: "").capitalized)", link: "")]
    }
    
    func setupCollection() {
        collectionViewForApp.dataSource = self
        collectionViewForApp.delegate = self
        collectionViewForApp.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        collectionViewForApp.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionViewForApp.collectionViewLayout = layout
    }
}

extension InfoViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewForApp.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! InfoCollectionViewCell
        cell.cellLabel.text = viewModel?[indexPath.item].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - 40
        let width = availableWidth
        return CGSize(width: width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            requestAppReview()
        case 1:
            shareContent()
        case 2:
            openBrowser()
        default:
            break
        }
    }
    
    func requestAppReview() {
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview()
        } else {}
    }
    
    func shareContent() {
        let textToShare = "TestApp"
        let urlToShare =  URL(string: "https://energise.notion.site/Swift-fac45cd4d51640928ce8e7ea38552fc3")
        let activityItems: [Any] = [textToShare, urlToShare as Any]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = UIApplication.shared.windows.first?.rootViewController?.view
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    func openBrowser() {
        if let url = URL(string: "https://energise.notion.site/Swift-fac45cd4d51640928ce8e7ea38552fc3") {
            UIApplication.shared.open(url)
        }
    }
}
