//
//  ViewController.swift
//  ScrollViewTutorial
//
//  Created by Lin David, US-205 on 11/6/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    let tourData = [
        [
            "image" : "introtour01",
            "title" : "Treehouse Mobile is ready when you are",
        ],
        [
            "image" : "introtour02",
            "title" : "Over 150 courses and growing",
        ],
        [
            "image" : "introtour03",
            "title" : "Write actual code",
        ],
        [
            "image" : "introtour04",
            "title" : "Track your success",
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.pagingEnabled = true
        setupImageViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createPageView(data: [String: String]) -> PageView {
        let pageView = PageView.loadFromNib()
        pageView.configure(data)
        return pageView
    }
    
    func setupImageViews() {
        var totalWidth: CGFloat = 0
        
        for data in tourData {
            let pageView = createPageView(data)
            pageView.frame = CGRect(origin: CGPoint(x: totalWidth, y:0),
                                     size: view.bounds.size)
            pageView.imageView.contentMode = .ScaleAspectFit
            
            scrollView.addSubview(pageView)
            totalWidth += pageView.bounds.size.width
        }
        
        scrollView.contentSize = CGSize(width: totalWidth, height: scrollView.bounds.size.height)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = Int(scrollView.contentSize.width) / tourData.count
        pageController.currentPage = Int(scrollView.contentOffset.x) / pageWidth
    }
}

