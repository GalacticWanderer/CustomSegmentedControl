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
    let subViewForSegCtrl = UIView()
    let activeSegCtrlIndicator = UIView()
    let meetupHistoryLabel = UILabel()
    let containerView = UIView()
    
    let tagVC:UIView = TagViewController().view
    let meetVC:UIView = MeetViewController().view
    let pointsVC:UIView = PointsViewController().view
    
    //tuples
    let tagAtt = (155, "TRASHTAG")
    let meetupAtt = (12, "MEETUPS")
    let pointsAtt = (800, "POINTS")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        
        configureProfilePhoto()
        
        configureNameandCityLabel()
        
        setUpSegCtrl()
        configureSegCtrlConstraints()
        customizeSegCtrl()
        
        configureMeetupHistoryLabel()
        
        addViewsForContainer()
    }
    
    func configureNavBar(){
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
        
        //sets number of lines of text
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 2
        
        segmentedCtrl.insertSegment(withTitle: "\(tagAtt.0)\n\(tagAtt.1)", at: 0, animated: true)
        segmentedCtrl.insertSegment(withTitle: "\(meetupAtt.0)\n\(meetupAtt.1)", at: 1, animated: true)
        segmentedCtrl.insertSegment(withTitle: "\(pointsAtt.0)\n\(pointsAtt.1)", at: 2, animated: true)
        
        segmentedCtrl.selectedSegmentIndex = 0
    }
    
    func configureSegCtrlConstraints(){
        segmentedCtrl.translatesAutoresizingMaskIntoConstraints = false
        subViewForSegCtrl.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 98)
        subViewForSegCtrl.backgroundColor = UIColor.white
        subViewForSegCtrl.addSubview(segmentedCtrl)
        
        segmentedCtrl.topAnchor.constraint(equalTo: subViewForSegCtrl.topAnchor).isActive = true
        segmentedCtrl.bottomAnchor.constraint(equalTo: subViewForSegCtrl.bottomAnchor).isActive = true
        segmentedCtrl.leftAnchor.constraint(equalTo: subViewForSegCtrl.leftAnchor).isActive = true
        segmentedCtrl.rightAnchor.constraint(equalTo: subViewForSegCtrl.rightAnchor).isActive = true
        segmentedCtrl.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        subViewForSegCtrl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subViewForSegCtrl)
        
        subViewForSegCtrl.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        subViewForSegCtrl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        subViewForSegCtrl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        subViewForSegCtrl.heightAnchor.constraint(equalToConstant: 88).isActive = true
    }
    
    func customizeSegCtrl(){
        segmentedCtrl.backgroundColor = UIColor.white
        segmentedCtrl.tintColor = UIColor.white
        
        activeSegCtrlIndicator.translatesAutoresizingMaskIntoConstraints = false
        activeSegCtrlIndicator.backgroundColor = UIColor.blue
        subViewForSegCtrl.addSubview(activeSegCtrlIndicator)
        
        activeSegCtrlIndicator.topAnchor.constraint(equalTo: subViewForSegCtrl.bottomAnchor, constant: -5).isActive = true
        activeSegCtrlIndicator.heightAnchor.constraint(equalToConstant: 8.7).isActive = true
        activeSegCtrlIndicator.leftAnchor.constraint(equalTo: subViewForSegCtrl.leftAnchor).isActive = true
        activeSegCtrlIndicator.widthAnchor.constraint(equalTo: subViewForSegCtrl.widthAnchor, multiplier: 1 / CGFloat(segmentedCtrl.numberOfSegments)).isActive = true
        
        //configure subView's shadow
        subViewForSegCtrl.layer.shadowColor = UIColor.darkGray.cgColor
        subViewForSegCtrl.layer.shadowOpacity = 0.3
        subViewForSegCtrl.layer.shadowOffset = .zero
        
        
        
        
        segmentedCtrl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "MarkerFelt-Thin", size: 16)!,
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
            ], for: .normal)
        
        segmentedCtrl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "MarkerFelt-Thin", size: 16)!,
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
            ], for: .selected)
        
        
        let responder = UIResponder()
        
        //we add a listener for the value being changed by passing the responder, an objective-C runtime func for the behavior valueChanged
        //**note objc funcs are always inside a #selector()
        segmentedCtrl.addTarget(responder, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    func configureMeetupHistoryLabel(){
        meetupHistoryLabel.text = "Meetup History"
        meetupHistoryLabel.font = UIFont(name: "MarkerFelt-Wide", size: 12)
        
        meetupHistoryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(meetupHistoryLabel)
        meetupHistoryLabel.topAnchor.constraint(equalTo: subViewForSegCtrl.bottomAnchor, constant: 19).isActive = true
        meetupHistoryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        meetupHistoryLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //meetupHistoryLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    func addViewsForContainer(){
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: meetupHistoryLabel.bottomAnchor, constant: 12.4).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        containerView.addSubview(tagVC)
        containerView.addSubview(meetVC)
        containerView.addSubview(pointsVC)
    }
    
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl){
        //we animate the buttonBar to go underneath the selected control
        UIView.animate(withDuration: 0.3) {
            self.activeSegCtrlIndicator.frame.origin.x = (self.segmentedCtrl.frame.width / CGFloat(self.segmentedCtrl.numberOfSegments)) * CGFloat(self.segmentedCtrl.selectedSegmentIndex)
        }
        
        //TODO add views
        
        switch segmentedCtrl.selectedSegmentIndex{
        case 0:
            containerView.bringSubviewToFront(tagVC)
        case 1:
            containerView.bringSubviewToFront(meetVC)
        case 2:
            containerView.bringSubviewToFront(pointsVC)
            
        default:
            print("Whaaa")
        }
        
    }

}

