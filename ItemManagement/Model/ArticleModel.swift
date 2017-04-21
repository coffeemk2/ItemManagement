//
//  ItemModel.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/04/01.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON
import RxSwift
import RxRealm

class ArticleModel{
    private let disposeBag = DisposeBag()
    
    var requestState = Variable(RequestState.stopped)
    
    
    func createItems(){

        let items:Observable<[Article]> = Observable.just([ Article(name: "iPad Air (青)", image: "hoge", place: "棚 2段目"),
                                      Article(name: "MacBookAir 13-inch", image: "hoge", place: "棚 3段目"),
                                      Article(name: "カメラ Canon", image: "hoge", place: "倉庫左の棚下から2番目")
                                    ])
        
        items.subscribe(onNext: { elements in
            self.requestState.value = .response(elements)
        }).disposed(by: disposeBag)
        
        items.subscribe(Realm.rx.add()).disposed(by: disposeBag)
    }
    
    func getObservableFromDB<T:Object>(type: T.Type)->Observable<[T]>{
        let realm = try! Realm()
        let elements = realm.objects(type)
        return Observable.array(from: elements)
    }
    
    
}
