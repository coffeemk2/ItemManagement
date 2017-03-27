//
//  ActSelectionViewController.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/10.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import UIKit

class ActSelectionViewController: UIViewController {

    
    var userListViewFrame:CGRect! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func borrowButton(_ sender: Any) {
        performSegue(withIdentifier: "userList", sender: nil)
    }

    
    func curlUpView(view:UIView, endFrame:CGRect){
        let initialFrame = CGRect(x: endFrame.origin.x , y: self.view.frame.height, width: endFrame.size.width, height: endFrame.size.height)
        view.frame = initialFrame
        self.view.addSubview(view)
        
        UIView.animate(withDuration: 0.5) {
            view.frame = endFrame
        }
        
    }
    
    func downAndRemoveView(view:UIView){
        let frame = view.frame
        let endFrame = CGRect(x: frame.origin.x, y: self.view.frame.height, width: frame.size.width, height: frame.size.height)
        
//        self.view.setNeedsLayout()
        
        UIView.animate(withDuration: 0.5, animations: { 
            view.frame = endFrame
        }) { (bool) in
            view.removeFromSuperview()
        }
        
    }
    
    
    
    
    
//    func hideContentController(content:UIViewController){
//        content.willMove(toParentViewController: nil)
//        content.view.removeFromSuperview()
//        content.removeFromParentViewController()
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


