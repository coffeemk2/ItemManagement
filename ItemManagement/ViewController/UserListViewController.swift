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

class UserListViewController: UIViewController {
    
    var modallyViewController :ModalViewController! = ModalViewController()
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var userListTableView: UITableView!

    private let viewModel = UserViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // TableView Configure
        viewModel.cellData.bindTo(userListTableView.rx.items(cellIdentifier: "userList", cellType: UserTableViewCell.self)){ index, item ,cell in
            cell.fullnameLabel.text = item.0.fullname
            cell.usernameLabel.text = "@" + item.0.name
            cell.profileImageView.sd_setImage(with: URL(string: item.0.urlString) )
            if item.1{
                cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "common_check"))
            }else{
                cell.accessoryView = nil
            }
        }.disposed(by: disposeBag)
        
        userListTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            self.modallyViewController.display(parent: self)
            self.viewModel.selectedUser.value = self.viewModel.users.value[indexPath.row]
        }).disposed(by: disposeBag)
        
        userListTableView.rx.itemDeselected.subscribe(onNext: { indexPath in
        }).disposed(by: disposeBag)
        
        
        viewModel.scrollEndComing.value = true
        
        
        // ModalView Configure
        modallyViewController.createContentsWithText(goText: "Next", cancel: "Cancel", labelEnable: true, backgroundColor: Constants.Color.actBorrow)
        
        viewModel.selectedUser.asObservable().map { (user) -> String? in
            guard let user = user else { return nil }
            let name = user.fullname != "" ? user.fullname : user.name
            return "Are you \(name) ?"
            }.bindTo(modallyViewController.textLabel.rx.text).disposed(by: disposeBag)
        
        
        modallyViewController.goButton.rx.tap.subscribe{ [unowned self] _ in
            self.performSegue(withIdentifier: "itemList", sender: nil)
            }.disposed(by: disposeBag)
        
        modallyViewController.cancelButton.rx.tap.subscribe{ [unowned self] _ in
            if let indexPath = self.userListTableView.indexPathForSelectedRow{
                self.userListTableView.deselectRow(at: indexPath, animated: true)
            }
            self.viewModel.selectedUser.value = nil
            self.modallyViewController.dismiss(parent: self)
            }.disposed(by: disposeBag)
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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



