//
//  ViewController.swift
//  CustomSegmentedCtrl
//
//  Created by Joy Paul on 4/8/19.
//  Copyright © 2019 Joy Paul. All rights reserved.
//

import UIKit

//this example shows you how to setup segmented controls with a little bar at the bottom and customize them programatically

class ViewController: UIViewController {

    //this is a placeholder view from the storyBoard, this is where our profile pics and the names will go
    //we can make it programatically too and we might as well later on
    @IBOutlet weak var prfileInfoView: UIView!
    
    //we init a segmented control to use in our functions down below
    let segmentedControl = UISegmentedControl()
    
    //we also init a buttonBar that will go underneath the controls
    let buttonBar = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSegCtrl()
        
    }
    
    //this func sets up how many Seg. controls we will have. 3 controls in this case.
    func setUpSegCtrl(){
        
        //inserting segmenetedControl one at a time with their title (you can use image too), their position "at",
        //and animatiomn to true
        segmentedControl.insertSegment(withTitle: "One", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Two", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "Three", at: 2, animated: true)
        
        //we are passing a default Seg. control position. It's position 0 in this case
        segmentedControl.selectedSegmentIndex = 0
        
        //this is where we would call the view with the data in it
        view.backgroundColor = .yellow
        
        //se setup the constraints in this func
        setUpSegCtrlConstraints()
    }
    
    //much like the storyBoard, we can also set-up constraints programatically, and this func does just that
    func setUpSegCtrlConstraints(){
        //we need translatesAutoresizingMaskIntoConstraints to be false for doing things programatically
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        //adding segmentedControl to our main view as a subView
        view.addSubview(segmentedControl)
        
        //giving the positioning constarints to our segmentedControl view
        segmentedControl.topAnchor.constraint(equalTo: prfileInfoView.bottomAnchor, constant: 20).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        //doing the same things but for buttonBar now
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        //this is a random color for the buttonBar, it can be anything the designer wants it to be
        buttonBar.backgroundColor = .purple
        view.addSubview(buttonBar)
        
        //passing the constraints again for buttonBar
        buttonBar.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        buttonBar.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        //specifying the buttonBar's width and dividing it by the number of controls. Otherwise it would just be a long line
        buttonBar.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)).isActive = true
        
        //calling to customize the controls
        customizeSegCtrl()
    }
    
    //we can customize our controls so we can vary from apple's ugly ass default designs, this func does just that
    func customizeSegCtrl(){
        //setting background and tint color to clear
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        
        //sets font, size and color for two states of the controls: normal and selected.
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray//light grey for normal
            ], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedString.Key.foregroundColor: UIColor.orange//orange for selected
            ], for: .selected)
        
        //we use this responder variable to figure out where the user is at e.g. page 1, 2, or 3
        let responder = UIResponder()
        
        //we add a listener for the value being changed by passing the responder, an objective-C runtime func for the behavior valueChanged
        //**note objc funcs are always inside a #selector()
        segmentedControl.addTarget(responder, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    //the actual objc runtime func that handles buttonBar animation and the page transitions
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl){
        //we animate the buttonBar to go underneath the selected control
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedControl.frame.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)
        }
        
        //And finally, this is were we would call our custom views when the user switches controls
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            view.backgroundColor = .yellow
        case 1:
            view.backgroundColor = .green
        case 2:
            view.backgroundColor = .red
        default:
            view.backgroundColor = .brown
            
        }
        
    }

}

