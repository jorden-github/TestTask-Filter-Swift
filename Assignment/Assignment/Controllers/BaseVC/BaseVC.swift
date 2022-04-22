//
//  BaseVC.swift
//  Assignment
//
//  Created by Jorden Williams on 22/04/2022.
//

import Foundation
import UIKit
import MBProgressHUD

class BaseVC: UIViewController {
     func showHud(vc : UIViewController){
        MBProgressHUD.showAdded(to: vc.view, animated: true)
    }
     func hideHud(vc : UIViewController){
        MBProgressHUD.hide(for: vc.view, animated: true)
    }
}
