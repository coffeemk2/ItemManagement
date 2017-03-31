//
//  ModalViewController.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/10.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ModalViewController: UIViewController {
    
    var goButton: UIButton! = UIButton(type: .system)
    var cancelButton: UIButton! = UIButton(type: .system)
    var textLabel: UILabel! = UILabel()
        
    private var height:CGFloat = 0
    private let margin: CGFloat = 20.0
    private let marginWithContent: CGFloat = 8.0
    private let marginInsideButton: CGFloat = 30.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeight()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createContentsWithText(goText: String?, cancel:String?, labelEnable:Bool, backgroundColor: UIColor){
        let font = UIFont(name: "Lato-Regular", size: 18.0)
        let buttonHeight = String("A").size(attributes: [NSFontAttributeName : font ?? UIFont.systemFont(ofSize: 18.0)]).height
        
        if let text = goText as NSString?{
            let width = text.size(attributes: [NSFontAttributeName : font ?? UIFont.systemFont(ofSize: 18.0)]).width
            let rect = CGRect(x: self.view.frame.width - width - margin - marginInsideButton*2, y: margin, width: width + marginInsideButton*2 , height: buttonHeight + 10)
            goButton.frame = rect
            self.goButton.backgroundColor = Constants.Color.main
            self.goButton.setTitle(text as String, for: .normal)
            self.goButton.titleLabel?.font = font
            self.goButton.setTitleColor(UIColor.white, for: .normal)
            self.goButton.layer.cornerRadius = 8.0
            self.view.addSubview(self.goButton)
        }
        
        if let text = cancel as NSString?{
            let width = text.size(attributes: [NSFontAttributeName : font ?? UIFont.systemFont(ofSize: 18.0)]).width
            let rightContentX = (goText != nil) ? self.goButton.frame.origin.x : self.view.frame.width
            let rect = CGRect(x: rightContentX - width - marginInsideButton*2 - marginWithContent, y: margin, width: width + marginInsideButton*2 , height: buttonHeight + 10)
            cancelButton.frame = rect
            self.cancelButton.backgroundColor = UIColor.white
            self.cancelButton.setTitle(text as String, for: .normal)
            self.cancelButton.titleLabel?.font = font
            self.cancelButton.setTitleColor(Constants.Color.gray, for: .normal)
            self.cancelButton.layer.cornerRadius = 8.0
            self.view.addSubview(self.cancelButton)
        }
        
        if labelEnable{
            let rightContentX = (self.cancelButton != nil) ? self.cancelButton.frame.origin.x : (goText != nil) ? self.goButton.frame.origin.x : self.view.frame.width
            let rect = CGRect(x: margin, y: margin + 5, width: rightContentX - marginWithContent - margin, height: buttonHeight )
            self.textLabel.frame = rect
            self.textLabel.font = font
            self.textLabel.textColor = UIColor.white
            self.textLabel.textAlignment = .right
            self.view.addSubview(self.textLabel)
        }
        
        self.view.backgroundColor = backgroundColor
    }
    
    private func setupHeight(){
        let font = UIFont(name: "Lato-Regular", size: 18.0)
        self.height = NSString(string: "A").size(attributes: [NSFontAttributeName : font ?? UIFont.systemFont(ofSize: 18.0)]).height + 10 + margin*2
        
    }
    
    private func isPresented()->Bool{
        return (self.parent != nil) ? true : false
    }
    
    func display(parent: UIViewController){
        if self.isPresented() { return }
        parent.addChildViewController(self)
        parent.view.addSubview(self.view)
        self.view.frame = CGRect(x: 0, y: parent.view.frame.height, width: parent.view.frame.width, height: height)
        UIView.animate(withDuration: 0.5, animations: {
            self.view.frame = CGRect(x: 0, y: parent.view.frame.height - self.height, width: parent.view.frame.width, height: self.height)
        }) { _ in
            self.didMove(toParentViewController: parent)
        }
    }
    
    func dismiss(parent: UIViewController){
        if !self.isPresented() { return }
        self.willMove(toParentViewController: nil)
        UIView.animate(withDuration: 0.5, animations: {
            self.view.frame = CGRect(x: 0, y: parent.view.frame.height, width: parent.view.frame.width, height: self.height)
        }) { _ in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}




