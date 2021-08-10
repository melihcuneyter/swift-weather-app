//
//  ViewController.swift
//  WeatherAppFull
//
//  Created by Melih Cüneyter on 5.08.2021.
//

import UIKit

@available(iOS 13.0, *)
class ViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    var locationNames = [String]()
    var currentViewControllerIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        locationNames = UserDefaults.standard.array(forKey: "newLocation") as? [String] ?? ["Veri Yok"]
        view.backgroundColor = .lightGray
        configurePageViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationNames = UserDefaults.standard.array(forKey: "newLocation") as? [String] ?? ["Veri Yok"]
        UserDefaults.standard.set(locationNames, forKey: "newLocation")
        print(locationNames.count)
        configurePageViewController()
    }
    
    // MARK: Setup pageViewController
    func configurePageViewController() {
        guard let pageViewController = storyboard?.instantiateViewController(identifier: String(describing: "CustomPageViewController")) as? CustomPageViewController else {
            return
        }
        pageViewController.delegate = self
        pageViewController.dataSource = self
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.backgroundColor = .lightGray
        contentView.addSubview(pageViewController.view)
        let views: [String : Any] = ["pageView": pageViewController.view!]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else {
            return
        }
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
    }
    
    func detailViewControllerAt(index: Int) -> DataViewController? {
        if index >= locationNames.count || locationNames.count == 0 {
            return nil
        }
        guard let dataViewController = storyboard?.instantiateViewController(identifier: String(describing: DataViewController.self)) as? DataViewController else {
            return nil
        }
        dataViewController.index = index
        dataViewController.displayText = locationNames[index]
        return dataViewController
    }
}

@available(iOS 13.0, *)
extension ViewController: UIPageViewControllerDelegate {
    
}

@available(iOS 13.0, *)
extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? DataViewController
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        currentViewControllerIndex = currentIndex
        if currentIndex == 0 {
            return nil
        }
        currentIndex -= 1
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? DataViewController
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        if currentIndex == locationNames.count {
            return nil
        }
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        return detailViewControllerAt(index: currentIndex)
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return locationNames.count
    }
}



