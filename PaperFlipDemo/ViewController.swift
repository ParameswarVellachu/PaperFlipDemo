//
//  ViewController.swift
//  PaperFlipDemo
//
//  Created by Parameswaran on 01/08/24.
//

import UIKit

struct UserListModel {
    var title: String
    var image: String
    var description: String
}

class ViewController: UIViewController {
    
    var pageController: UIPageViewController?
    var pageContent = [UserListModel]()
    
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
        
        pageContent = [UserListModel(title: "Rose1", image: "rose-1", description: "rose1 description"),
        UserListModel(title: "Rose2", image: "rose-2", description: "rose2 description"),
        UserListModel(title: "Rose3", image: "rose-3", description: "rose3 description"),
        UserListModel(title: "Rose4", image: "rose-4", description: "rose4 description"),
        UserListModel(title: "Rose5", image: "rose-5", description: "rose5 description"),
        UserListModel(title: "Rose6", image: "rose-6", description: "rose6 description")]
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
        
        dataViewController.dataObject = pageContent[index]
        return dataViewController
    }
    
    func indexOfViewController(viewController: ContentViewController) -> Int {
        
        if let dataObject = viewController.dataObject {
            return pageContent.indexOf(element: dataObject)!
        } else {
            return NSNotFound
        }
    }
}

extension Collection where Iterator.Element == UserListModel {
    func indexOf(element: UserListModel) -> Index? {
        return firstIndex(where: { $0.title == element.title })
    }
}
