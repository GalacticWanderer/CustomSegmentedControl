//
//  ViewController.swift
//  CustomSegmentedCtrl
//
//  Created by Joy Paul on 4/8/19.
//  Copyright © 2019 Joy Paul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usrNameLabel: UILabel!
    @IBOutlet weak var usrCityLabel: UILabel!
    let segmentedCtrl = UISegmentedControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBare()
        configureProfilePhoto()
        configureNameandCityLabel()
        setUpSegCtrl()
        configureSegCtrlConstraints()
    }
    
    func configureNavBare(){
        let appBar = navigationController?.navigationBar
        
        appBar?.backgroundColor = UIColor.blue
        appBar?.tintColor = UIColor.blue
        appBar!.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        appBar!.shadowImage = UIImage()
    }
    
    func configureProfilePhoto(){
    
        profileImageView.image = UIImage(named: "userPhoto")
        profileImageView.contentMode = .scaleAspectFill
        
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
    }
    
    func configureNameandCityLabel(){
        usrNameLabel.text = "Cosmic Rover"
        usrNameLabel.textColor = UIColor.white
        
        usrCityLabel.text = "New York City"
        usrCityLabel.textColor = UIColor.white
    }
    
    func setUpSegCtrl(){
        segmentedCtrl.insertSegment(withTitle: "155", at: 0, animated: true)
        segmentedCtrl.insertSegment(withTitle: "12", at: 1, animated: true)
        segmentedCtrl.insertSegment(withTitle: "800", at: 2, animated: true)
        
        segmentedCtrl.selectedSegmentIndex = 0
    }
    
    func configureSegCtrlConstraints(){
        segmentedCtrl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedCtrl)
        
        segmentedCtrl.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
        segmentedCtrl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        segmentedCtrl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        segmentedCtrl.heightAnchor.constraint(equalToConstant: 88).isActive = true
    }

}

