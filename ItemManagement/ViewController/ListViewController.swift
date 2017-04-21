//
//  ListViewController.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/10.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ListViewController: UIViewController {

    let modallyViewController :ModalViewController! = ModalViewController()
    
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var itemTableView: UITableView!
    
    private let viewModel = CategoryViewModel()
    private let disposeBag = DisposeBag()
    private var dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // category tableview
        viewModel.categoryTable.bindTo(categoryTableView.rx.items(cellIdentifier: "categories", cellType: UITableViewCell.self)){ index, item, cell in
            cell.textLabel?.text = item.0.name
            cell.accessoryView = item.1 ? UIImageView(image: #imageLiteral(resourceName: "common_check")) : nil
        }.disposed(by: disposeBag)
        
        categoryTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            let target = self.viewModel.categories.value[indexPath.row]
            self.viewModel.selectedCategory.value = self.viewModel.selectedCategory.value == target ? nil : target
        }).disposed(by: disposeBag)
        
        // item tableview
        dataSource.configureCell = {(ds, tv, ip, item ) in
            let cell = tv.dequeueReusableCell(withIdentifier: "items", for: ip) as! ItemTableViewCell
            cell.nameLabel.text = item.0.name
            cell.placeLabel.text = item.0.place
            cell.accessoryView = item.1 ? UIImageView(image: #imageLiteral(resourceName: "common_check")) : nil
            return cell
        }
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        
        viewModel.itemTable.bindTo(itemTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        itemTableView.rx.itemSelected.subscribe(onNext:{ ip in
            let model = self.dataSource[ip.section].items[ip.row].0
            self.viewModel.addSelectedArticle(article: model)
            self.viewModel.selectedItems.value == [] ? self.modallyViewController.dismiss(parent: self) : self.modallyViewController.display(parent: self)
        }).disposed(by: disposeBag)
        
        
        // ModalView Configure
        modallyViewController.createContentsWithText(goText: "Next", cancel: "Deselect All", labelEnable: true, backgroundColor: Constants.Color.actBorrow)
        
        viewModel.selectedItems.asObservable().map{ a -> String in
            return a.reduce("You selected", { (text, article) -> String in
                return text.appending(" \"\(article.name)\"")
            })
            }.bindTo(modallyViewController.textLabel.rx.text).disposed(by: disposeBag)
        
        
        modallyViewController.goButton.rx.tap.subscribe{ [unowned self] _ in
            self.performSegue(withIdentifier: "calendar", sender: nil)
            }.disposed(by: disposeBag)
        
        modallyViewController.cancelButton.rx.tap.subscribe{ [unowned self] _ in
            self.viewModel.selectedItems.value = []
            self.modallyViewController.dismiss(parent: self)
            }.disposed(by: disposeBag)


        // Do any additional setup after loading the view.
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
