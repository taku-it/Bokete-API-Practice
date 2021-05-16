//
//  CheckPermission.swift
//  Bokete
//
//  Created by 生田拓登 on 2021/05/15.
//

import Foundation
import Photos

class CheckPermission{
    
    func checkCamera(){
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status) {
            
            case .authorized:
                print("authorized")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .limited:
                print("limited")
            @unknown default:
                break
            }
        }
    }
    
}
