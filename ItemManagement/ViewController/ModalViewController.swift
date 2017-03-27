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
    
    weak var goButton: UIButton? = nil
    weak var cancelButton: UIButton? = nil
    weak var textLabel: UILabel? = nil
    var height:CGFloat = 44
    
    var nextSegue: String = ""
    var backgroundColor = UIColor.red
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        
        
        goButton?.rx.tap.subscribe(onNext:{ [unowned self] _ in
            self.parent?.performSegue(withIdentifier: self.nextSegue, sender: nil)
        }).addDisposableTo(disposeBag)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func createContentsWithText(goButton: String?, cancel:String?, label:Bool){
//        let font = UIFont(name: "", size: <#T##CGFloat#>)
//        if let goButton {
//            self.goButton = UIButton(frame: <#T##CGRect#>)
//        }
//    }
    
    private func setup(){
        let parentView = self.parent?.view
        self.view.frame = CGRect(x: 0, y: (parentView?.frame.size.height)! - self.height, width: (parentView?.frame.size.width)!, height: self.height)
        self.view.backgroundColor = self.backgroundColor
        
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

