//
//  InitialPageViewController.swift
//  Foundation1
//
//  Created by Foundation_30 on 14/05/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class InitialPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageControl = UIPageControl()
    
    @IBOutlet weak var firstQValueLabel: UILabel!
    
    @IBAction func sliderChange(_ sender: UISlider) {
        firstQValueLabel.text = String(Int(sender.value))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard  let currentIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = currentIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard orderedViewControllers.count > previousIndex else { return nil }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard  let currentIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = currentIndex + 1
        
        
        guard orderedViewControllers.count != nextIndex else { return nil }
        
        guard orderedViewControllers.count > nextIndex else { return nil }
        
        return orderedViewControllers[nextIndex]
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newQuestionViewController(question: "1"),
                self.newQuestionViewController(question: "2")]
    }()
    
    private func newQuestionViewController(question: String)-> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(question)QuestionViewController")
        
    }

    /*func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }*/
    
}
