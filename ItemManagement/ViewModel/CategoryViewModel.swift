//
//  CategoryViewModel.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/04/03.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxRealm
import RxDataSources

class CategoryViewModel{
    private let categoryModel = CategoryModel()
    private let disposeBag = DisposeBag()
    private let scheduler = RxScheduler.sharedInstance
    internal var categories :Variable<[Category]> = Variable([])
    internal let viewState = Variable(ViewState.blank)
    internal var selectedItems :Variable<[Article]> = Variable([])
    internal var selectedCategory :Variable<Category?> = Variable(nil)
    internal var categoryTable :Observable<[(Category,Bool)]>{
        return Observable.combineLatest(categories.asObservable(), selectedCategory.asObservable(), resultSelector: { (elements,selected) in
            return elements.map({$0.name == selected?.name ? ($0,true) : ($0,false)})
        })
    }

    internal var itemTable :Observable<[SectionOfCustomData]>{
        return Observable.combineLatest(categories.asObservable(),selectedCategory.asObservable(),selectedItems.asObservable()){ (categories, selectedCategory, selectedItems ) in
            if let sc = selectedCategory{
                let items = sc.articles.toArray().map{selectedItems.contains($0) ? ($0,true) : ($0,false)}
                return [SectionOfCustomData(header: sc.name, items: items)]
            }
            return categories.map{ SectionOfCustomData(header: $0.name, items: $0.articles.toArray().map{ selectedItems.contains($0) ? ($0,true) : ($0,false) })  }
        }
    }
    

    
    
    init() {        
        categoryModel.requestStateFromDB(type: Category.self)
        
        categoryModel
            .requestState
            .asObservable()
            .subscribeOn(scheduler.serialBackground)
            .observeOn(scheduler.main)
            .subscribe { (event) in
                self.subscribeState(state: event.element!)
                print(self.viewState.value)
            }.disposed(by: disposeBag)
    }
    
    func addSelectedArticle(article: Article){
        if let index = self.selectedItems.value.index(of: article){
            self.selectedItems.value.remove(at: index)
        }else{
            self.selectedItems.value.append(article)
        }
    }
    
    
    func subscribeState(state: RequestState) {
        switch state {
        case .stopped:
            self.viewState.value = .blank
        case .requesting:
            self.viewState.value = .requesting
        case .error(let error):
            self.viewState.value = .error(error)
        case .response(let response):
            let categories = response as? [Category] ?? []
            self.viewState.value = .working
            self.categories.value = categories
        }
    }
    
    
}



struct SectionOfCustomData {
    var header: String
    var items: [(Article,Bool)]
}
extension SectionOfCustomData: SectionModelType {
    typealias Item = (Article,Bool)
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    } 
}
