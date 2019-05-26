//
//  OnBoardingContainerViewController.swift
//  PlatziFinanzas
//
//  Created by Manuel Alejandro Aguilar Tellez Giron on 3/24/19.
//  Copyright © 2019 Manuel Alejandro Aguilar Tellez Giron. All rights reserved.
//

import UIKit

class OnBoardingContainerViewController: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotosignin" {
            UserDefaults.standard.set(true, forKey: "WatchedOnBoarding")
            UserDefaults.standard.synchronize()
            
            return
        }
        
        guard segue.identifier == "openOnBoarding",
            let destination = segue.destination as? OnBoardingViewController else {
                return
        }
        destination.pageControl = pageControl
    }
}
