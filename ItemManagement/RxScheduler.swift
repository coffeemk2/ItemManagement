//
//  RxScheduler.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/27.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct RxScheduler {
    static let sharedInstance = RxScheduler()
    let main: SerialDispatchQueueScheduler
    let serialBackground: SerialDispatchQueueScheduler
    let concurrentBackground: ImmediateSchedulerType
    
    init() {
        main = MainScheduler.instance
        serialBackground = SerialDispatchQueueScheduler(qos: .default)
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        concurrentBackground = OperationQueueScheduler(operationQueue: operationQueue)
    }
}
