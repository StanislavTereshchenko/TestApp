//
//  MapsViewController.swift
//  TestApp
//
//  Created by Stanislav Tereshchenko on 26.04.2024.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var theMapView: MKMapView!
    
    @IBOutlet weak var contryLabel: UILabel!
    @IBOutlet weak var contryCodeLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    var locationData: [String: Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupLabels()
        setupButton()
        fetchAndDisplayLocationData()
        setupRefreshControll()
    }
    
    func setupRefreshControll() {
        let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            scrollView.refreshControl = refreshControl
    }
    
    @objc func refreshData() {
        fetchAndDisplayLocationData()
    }
    
    func setupButton() {
        reloadButton.setTitle(NSLocalizedString("reload", comment: "").capitalized, for: .normal)
        reloadButton.titleLabel?.font = UIFont(name: "Gilroy-Black", size: 20)
        reloadButton.setTitleColor(.white, for: .normal)
        reloadButton.layer.cornerRadius = reloadButton.bounds.size.height / 2
        reloadButton.layer.borderWidth = 2
        reloadButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func setupLabels() {
        contryLabel.font = UIFont(name: "Gilroy-Black", size: 20)
        contryLabel.textColor = .white
        contryCodeLabel.font = UIFont(name: "Gilroy-Black", size: 20)
        contryCodeLabel.textColor = .white
        regionLabel.font = UIFont(name: "Gilroy-Black", size: 20)
        regionLabel.textColor = .white
        coordinatesLabel.font = UIFont(name: "Gilroy-Black", size: 20)
        coordinatesLabel.textColor = .white
        cityLabel.font = UIFont(name: "Gilroy-Black", size: 20)
        cityLabel.textColor = .white
    }
    
    @IBAction func reloadData(_ sender: Any) {
        fetchAndDisplayLocationData()
    }
    
    func fetchAndDisplayLocationData() {
        NetworkManager.fetchLocationData { [weak self] result in
            switch result {
            case .success(let locationData):
                let locationDataObject = LocationDataObject(locationData)
                RealmManager.shared.save(locationDataObject)
                DispatchQueue.main.async {
                    self?.updateDisplay(with: locationData)
                    self?.scrollView.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print("Error fetching location data: \(error.localizedDescription)")
            }
        }
    }
    
    func updateDisplay(with locationData: LocationData) {
        updateMapView(with: locationData)
        updateInfoLabel(with: locationData)
    }
    
    func updateMapView(with locationData: LocationData) {
        let location = CLLocationCoordinate2D(latitude: locationData.latitude, longitude: locationData.longitude)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        theMapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        theMapView.addAnnotation(annotation)
    }

    func updateInfoLabel(with locationData: LocationData) {
        UIView.transition(with: self.contryLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.contryLabel.text = "\(NSLocalizedString("country", comment: "")): \(locationData.country)"
        }, completion: nil)
        
        UIView.transition(with: self.contryCodeLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.contryCodeLabel.text = "\(NSLocalizedString("countryCode", comment: "")): \(locationData.countryCode)"
        }, completion: nil)
        
        UIView.transition(with: self.regionLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.regionLabel.text = "\(NSLocalizedString("region", comment: "")): \(locationData.region)"
        }, completion: nil)
        
        UIView.transition(with: self.cityLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.cityLabel.text = "\(NSLocalizedString("city", comment: "")): \(locationData.city)"
        }, completion: nil)
        
        UIView.transition(with: self.coordinatesLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.coordinatesLabel.text = "\(NSLocalizedString("longitude", comment: "")): \(locationData.longitude)\n\(NSLocalizedString("latitude", comment: "")): \(locationData.latitude)"
        }, completion: nil)
    }
    
    func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension MapsViewController: MKMapViewDelegate {
    
    func displayLocationOnMap(latitude: Double, longitude: Double) {
        let mapView = MKMapView(frame: self.theMapView.bounds)
        mapView.delegate = self
        mapView.showsUserLocation = true
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(
            center: initialLocation.coordinate,
            latitudinalMeters: regionRadius * 2.0,
            longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation.coordinate
        mapView.addAnnotation(annotation)
        self.theMapView.addSubview(mapView)
    }
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        let identifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}
