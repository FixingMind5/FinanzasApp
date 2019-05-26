//
//  OnBoardingStepsViewController.swift
//  PlatziFinanzas
//
//  Created by Manuel Alejandro Aguilar Tellez Giron on 3/25/19.
//  Copyright © 2019 Manuel Alejandro Aguilar Tellez Giron. All rights reserved.
//

import UIKit

class OnBoardingStepsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var OnBoardingImage: UIImageView!
    
    var item: OnBoardingItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = item?.title
        descriptionLabel.text = item?.description
        OnBoardingImage.image = UIImage(named: item?.imageName ?? "")
    }
    

}
