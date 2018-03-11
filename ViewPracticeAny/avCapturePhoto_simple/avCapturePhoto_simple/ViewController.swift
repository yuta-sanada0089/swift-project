//
//  ViewController.swift
//  avCapturePhoto_simple
//
//  Created by yoshiyuki oshige on 2017/08/28.
//  Copyright © 2017年 yoshiyuki oshige. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // プレビュー用のビューとOutlet接続しておく
    @IBOutlet weak var previewView: UIView!
    // インスタンスの作成
    var session = AVCaptureSession()
    var photoOutputObj = AVCapturePhotoOutput() //写真への出力
    // 通知センターを作る
    let notification = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // セッション実行中ならば中断する
        if session.isRunning {
            return
        }
        // 入出力の設定
        setupInputOutput()
        // プレビューレイヤの設定
        setPreviewLayer()
        // セッション開始
        session.startRunning()
        // デバイスが回転したときに通知するイベントハンドラを設定する
        notification.addObserver(self, selector: #selector(self.changedDeviceOrientation(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    
    // シャッターボタンで実行する
    @IBAction func takePhoto(_ sender: Any) {
        let captureSetting = AVCapturePhotoSettings()
        captureSetting.flashMode = .auto
        captureSetting.isAutoStillImageStabilizationEnabled = true
        captureSetting.isHighResolutionPhotoEnabled = false
        // キャプチャのイメージ処理はデリゲートに任せる
        photoOutputObj.capturePhoto(with: captureSetting, delegate: self)
    }
    
    // 入出力の設定
    func setupInputOutput(){
        //解像度の指定
        session.sessionPreset = AVCaptureSession.Preset.photo
        
        // 入力の設定
        do{
            //デバイスの取得
            let device = AVCaptureDevice.default(
                AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                for: AVMediaType.video,// ビデオ入力
                position: AVCaptureDevice.Position.back) // バックカメラ
            
            // 入力元
            let input = try AVCaptureDeviceInput(device: device!)
            if session.canAddInput(input){
                session.addInput(input)
            } else {
                print("セッションに入力を追加できなかった")
                return
            }
        } catch let error as NSError {
            print("カメラがない\(error)")
            return
        }
        // 出力の設定
        if session.canAddOutput(photoOutputObj){
            session.addOutput(photoOutputObj)
        } else {
            print("セッションに出力できなかった")
            return
        }
    }
    
    // プレビューレイヤの設定
    func setPreviewLayer(){
        // プレビューレイヤを作る
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.masksToBounds = true
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        // previewViewに追加する
        previewView.layer.addSublayer(previewLayer)
    }
    // デバイスの向きが変わったときに呼び出すメソッド
    @objc func changedDeviceOrientation(_ notification :Notification){
        // photoOutputObj.connectionの回転向きをデバイスと合わせる
        if let photoOutputConnection = self.photoOutputObj.connection(with: AVMediaType.video){
            switch UIDevice.current.orientation {
            case .portrait:
                photoOutputConnection.videoOrientation = .portrait
            case .portraitUpsideDown:
                photoOutputConnection.videoOrientation = .portraitUpsideDown
            case .landscapeLeft:
                photoOutputConnection.videoOrientation = .landscapeLeft
            case .landscapeRight:
                photoOutputConnection.videoOrientation = .landscapeRight
            default:
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

