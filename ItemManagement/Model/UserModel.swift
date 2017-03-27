//
//  UserModel.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/22.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON
import RxSwift

class UserModel{
    
    private let disposeBag = DisposeBag()
    
    var requestState = Variable(RequestState.stopped)
    
    func getUser(){
        requestState.value = .requesting
        APIService.getUser().subscribe(onNext: { json in
            let array = json["members"].arrayValue
            let users = array.flatMap{User.parseJSON(json: $0)}
            self.requestState.value = .response(users)
        },onError:{ err in
            self.requestState.value = .error(err)
        }).disposed(by: disposeBag)
    }
    

    
    

}
