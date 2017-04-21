//
//  CategoryModel.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/04/03.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON
import RxSwift
import RxRealm


class CategoryModel{
    private let disposeBag = DisposeBag()
    
    var requestState = Variable(RequestState.stopped)
    
    func createItems(){
        
        let cat1 = Category(name: "Computers", articles: [ Article(name: "iPad Air (青)", image: "hoge", place: "棚 2段目"),
                                             Article(name: "MacBookAir 13-inch", image: "hoge", place: "棚 3段目"),
                                             Article(name: "カメラ Canon", image: "hoge", place: "倉庫左の棚下から2番目")])
        let cat2 = Category(name: "Books", articles: [ Article(name: "iPhone入門", image: "hoge", place: "棚 2段目"),
                                                        Article(name: "Deep Learning", image: "hoge", place: "棚 3段目"),
                                                        Article(name: "リーダブルコード", image: "hoge", place: "倉庫")])
        let list:Observable<[Category]> = Observable.just([cat1,cat2])
        
        list.subscribe(onNext: { elements in
            self.requestState.value = .response(elements)
        }).disposed(by: disposeBag)
        
        list.subscribe(Realm.rx.add()).disposed(by: disposeBag)
    }
    
    func getObservableFromDB<T:Object>(type: T.Type)->Observable<[T]>{
        let realm = try! Realm()
        let elements = realm.objects(type)
        return Observable.array(from: elements)
    }
    
    func requestStateFromDB<T:Object>(type: T.Type){
        self.requestState.value = .requesting
  
        do {
            let realm = try Realm()
            let elements = realm.objects(type)
            Observable.array(from: elements).subscribe(onNext:{ e in
                self.requestState.value = .response(e)
            },onError: { _ in
                self.requestState.value = .error(nil)
            }).disposed(by: disposeBag)
        } catch {
            self.requestState.value = .error(nil)
        }
        
    }

    
    
}


