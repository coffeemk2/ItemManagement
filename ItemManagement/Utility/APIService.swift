//
//  APIManager.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/22.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift
import RealmSwift



struct APIService{
    
    static func getUser() ->Observable<JSON>{
        return Observable.create{ observer -> Disposable in
            let request = Alamofire.request(SlackRouter.getUser()).responseJSON{ (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    observer.on(.next(json))
                    observer.on(.completed)
                    
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
            
            request.resume()
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}

enum RequestState{
    case stopped
    case requesting
    case error(Error?)
    case response([Object]?)
}
