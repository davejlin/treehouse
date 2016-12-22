//
//  MemoAudio.swift
//  VoiceMemo
//
//  Created by Screencast on 9/1/16.
//  Copyright © 2016 Treehouse Island, Inc. All rights reserved.
//

import Foundation
import AVFoundation

class MemoSessionManager {
    static let sharedInstance = MemoSessionManager()
    
    let session: AVAudioSession
    
    var permissionGranted: Bool {
        return session.recordPermission() == .Granted
    }
    
    private init() {
        session = AVAudioSession.sharedInstance()
        configureSession()
    }
    
    private func configureSession() {
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.setActive(true)
        } catch {
            print(error)
        }
    }
    
    func requestPermission(completion: Bool -> Void) {
        session.requestRecordPermission { permissionAllowed in
            completion(permissionAllowed)
        }
    }
}


class MemoRecorder {
    
    static let sharedInstance = MemoRecorder()
    
    private static let settings: [String: AnyObject] = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 22050.0,
        AVEncoderBitDepthHintKey: 16 as NSNumber,
        AVNumberOfChannelsKey: 1 as NSNumber,
        AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
    ]
    
    private static func outputURL() -> NSURL {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory: NSString = paths.first!
        
        let audioPath = documentsDirectory.stringByAppendingPathComponent("memo.m4a")
        
        return NSURL(string: audioPath)!
    }
    
    private let recorder: AVAudioRecorder
    
    private init() {
        self.recorder = try! AVAudioRecorder(URL: MemoRecorder.outputURL(), settings: MemoRecorder.settings)
        recorder.prepareToRecord()
    }
    
    func start() {
        recorder.record()
    }
    
    func stop() -> String {
        recorder.stop()
        return recorder.url.absoluteString
    }
}










































