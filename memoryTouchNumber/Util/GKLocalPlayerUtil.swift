//
//  GKLocalPlayerUtil.swift
//  memoryTouchNumber
//
//  Created by 内間理亜奈 on 2023/01/09.
//  Copyright © 2023 zhenya. All rights reserved.
//
import UIKit
import GameKit

struct GKLocalPlayerUtil {
    static var localPlayer: GKLocalPlayer = GKLocalPlayer();

    static func login(target: UIViewController) {
        self.localPlayer = GKLocalPlayer.local
        self.localPlayer.authenticateHandler = {(viewController, error) -> Void in
            guard let viewController = viewController else {
                print("LoginCheck: Success")
                if (error == nil){
                    print("LoginAuthentication: Success")
                }else{
                    print("LoginAuthentication: Failed")
                }
                return  
            }
            print("LoginCheck: Failed - LoginPageOpen")
            target.present(viewController, animated: true, completion: nil);
        }
    }
}
