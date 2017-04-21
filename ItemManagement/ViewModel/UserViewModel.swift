//
//  UserViewModel.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/22.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation
import RxSwift

class UserViewModel{
    private let userModel = UserModel()
    private let scheduler = RxScheduler.sharedInstance
    private let disposeBag = DisposeBag()
    internal let users: Variable<[User]> = Variable([])
    internal var selectedUser: Variable<User?> = Variable(nil)
    internal var cellData: Observable<[(User,Bool)]>{
        return Observable.combineLatest(users.asObservable(), selectedUser.asObservable(), resultSelector: { (elements,selected) in
                return elements.map({ e -> (User,Bool) in
                    return e.id == selected?.id ? (e,true) : (e,false)
                })
            }
        )
    }
    internal let viewState = Variable(ViewState.blank)
    internal let scrollEndComing = Variable(false)
    
    init() {
        scrollEndComing
            .asObservable()
            .subscribe(onNext: { [weak self] (scrollEndComing) in
                if (self?.viewState.value.fetchEnabled())! && scrollEndComing{
                    self?.userModel.getUser()
                }
            }).disposed(by: disposeBag)
        
        userModel
            .requestState
            .asObservable()
            .subscribeOn(scheduler.serialBackground)
            .observeOn(scheduler.main)
            .subscribe { (event) in
                self.subscribeState(state: event.element!)
                print(self.viewState.value)
            }.disposed(by: disposeBag)
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
            let users = response as? [User] ?? []
            self.viewState.value = .working
            self.scrollEndComing.value = false
            self.users.value = users
        }
    }
    
}




/**
 Viewの状態を扱うenum
 - .Working: 描画する要素があり、アプリが正常に動いている状態
 - .Blank: 描画する要素がない状態
 - .Requesting: 描画する要素を読み込んでいる状態
 - .Error(ErrorType): エラーが起きている状態
 */
enum ViewState {
    case working
    case blank
    case requesting
    case error(Error?)
    
    
    /**
     APIを叩いても良い状態かを判定
     */
    func fetchEnabled() -> Bool {
        switch self {
        case .blank, .working:
            return true
        default:
            return false
        }
    }
}

