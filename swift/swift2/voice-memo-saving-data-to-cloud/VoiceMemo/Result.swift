//
//  Result.swift
//  VoiceMemo
//
//  Created by Screencast on 9/3/16.
//  Copyright © 2016 Treehouse Island, Inc. All rights reserved.
//

import Foundation

protocol MemoErrorType: ErrorType {
    var description: String { get }
}

enum Result<T> {
    case Success(T)
    case Failure(MemoErrorType)
}