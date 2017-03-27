//
//  UserListViewController.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/10.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources



class UserListViewController: UIViewController {
    
    var modallyViewController :ModalViewController! = nil
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var userListTableView: UITableView!

    private let viewModel = UserViewModel()
    let items = Observable<[String]>.just(["maekawa","tomoki"])
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modallyViewController = ModalViewController()
        
        viewModel.users.asObservable().bindTo(userListTableView.rx.items(cellIdentifier: "userList", cellType: UserTableViewCell.self)){ index, item ,cell in
            cell.fullnameLabel.text = item.fullname
            cell.usernameLabel.text = "@" + item.name
            cell.profileImageView.sd_setImage(with: URL(string: item.urlString) )
        }.disposed(by: disposeBag)
        

        userListTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            self.displayContentController(content: self.modallyViewController)
        }).disposed(by: disposeBag)
        
        viewModel.scrollEndComing.value = true
        
//        viewModel.users.asObservable().bindTo(userListTableView.rx.items(cellIdentifier: "userList", cellType: UserTableViewCell.self)){
//            index, item ,cell in
//            cell.fullnameLabel.text = item
//        }.disposed(by: disposeBag)

        
//        userListTableView.rx.itemSelected.subscribe{ (self) in
//            self.displayContentController(content: self.modallyViewController)
//        }.disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayContentController(content: UIViewController){
        self.addChildViewController(content)
        self.view.addSubview(content.view)
        content.didMove(toParentViewController: self)
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

struct CustomData {
    var anInt: Int
    var aString: String
    var aCGPoint: CGPoint
}

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}
extension SectionOfCustomData: SectionModelType {
    typealias Item = CustomData
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    } 
}

