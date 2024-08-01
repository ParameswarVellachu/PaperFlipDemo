//
//  ViewController.swift
//  PaperFlipDemo
//
//  Created by Parameswaran on 01/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    var pageController: UIPageViewController?
    var pageContent = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createContentPages()
        
        pageController = UIPageViewController(
            transitionStyle: .pageCurl,
            navigationOrientation: .horizontal,
            options: nil)
        
        pageController?.delegate = self
        pageController?.dataSource = self
        
        let startingViewController: ContentViewController =
        viewControllerAtIndex(index: 0)!
        
        let viewControllers: NSArray = [startingViewController]
        pageController!.setViewControllers(viewControllers
                                           as? [UIViewController],
                                           direction: .forward,
                                           animated: false,
                                           completion: nil)
        
        self.addChild(pageController!)
        self.view.addSubview(self.pageController!.view)
        
        let pageViewRect = self.view.bounds
        pageController!.view.frame = pageViewRect
        pageController!.didMove(toParent: self)
    }
    
    func createContentPages() {
        
        var pageStrings = [String]()
        
        for i in 1...11 {
            let contentString = "<html><head></head><body><br><h1>Chapter \(i)</h1><p>This is the page \(i) of content displayed using UIPageViewController in iOS 8.</p></body></html>"
            pageStrings.append(contentString)
        }
        pageContent = pageStrings as NSArray
    }
}

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = indexOfViewController(viewController: viewController
                                          as! ContentViewController)
        
        if (index == pageContent.count-1) || (index == NSNotFound) {
            return nil
        }
        
        index = index + 1
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = indexOfViewController(viewController: viewController
                                          as! ContentViewController)
        
        index = index - 1
        if index == NSNotFound || index == -1 {
            return nil
        }
        
        return viewControllerAtIndex(index: index)
    }
}

extension ViewController {
    
    func viewControllerAtIndex(index: Int) -> ContentViewController? {
        
        if (pageContent.count == 0) ||
            (index >= pageContent.count) {
            return nil
        }
        
        let storyBoard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        let dataViewController = storyBoard.instantiateViewController(withIdentifier: "contentView") as! ContentViewController
        
        dataViewController.dataObject = pageContent[index] as AnyObject
        return dataViewController
    }
    
    func indexOfViewController(viewController: ContentViewController) -> Int {
        
        if let dataObject: AnyObject = viewController.dataObject {
            return pageContent.index(of: dataObject)
        } else {
            return NSNotFound
        }
    }
}
