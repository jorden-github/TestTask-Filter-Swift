//
//  FilterVC.swift
//  Assignment
//
//  Created by Jorden Williams on 22/04/2022.
//

import Foundation
import UIKit
import iOSDropDown

protocol FilterVCDelegate : class {
    func getFilteredData(selecAppearances : [Int]) -> Void
}
class FilterVC : BaseVC{
    //MARK: - weak Variables
    weak var delegate : FilterVCDelegate?
    
    //MARK: - Class Functions
    class func FilterVC()-> FilterVC{
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
    }
    //MARK: - Life Cycle
    override func viewDidLoad() {
    }
    //MARK: - Variables
    var selectedFilterArr : [Int] = []
    
    //MARK: - IBActions
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        self.delegate?.getFilteredData(selecAppearances: selectedFilterArr)
        self.dismiss(animated: true)
    }
    
    @IBAction func btn1(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white{
            selectedFilterArr.append(1)
            sender.backgroundColor = UIColor.green
        }else{
            if let index = selectedFilterArr.firstIndex(of: 1) {
                selectedFilterArr.remove(at: index)
                sender.backgroundColor = UIColor.white
            }
        }
    }
    
    @IBAction func btn2(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white{
            selectedFilterArr.append(2)
            sender.backgroundColor = UIColor.green
        }else{
            if let index = selectedFilterArr.firstIndex(of: 2) {
                selectedFilterArr.remove(at: index)
                sender.backgroundColor = UIColor.white
            }
        }
    }
    @IBAction func btn3(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white{
            selectedFilterArr.append(3)
            sender.backgroundColor = UIColor.green
        }else{
            if let index = selectedFilterArr.firstIndex(of: 3) {
                selectedFilterArr.remove(at: index)
                sender.backgroundColor = UIColor.white
            }
        }
    }
    
    @IBAction func btn4(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white{
            selectedFilterArr.append(4)
            sender.backgroundColor = UIColor.green
        }else{
            if let index = selectedFilterArr.firstIndex(of: 4) {
                selectedFilterArr.remove(at: index)
                sender.backgroundColor = UIColor.white
            }
        }
    }
    
    @IBAction func btn5(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white{
            selectedFilterArr.append(5)
            sender.backgroundColor = UIColor.green
        }else{
            if let index = selectedFilterArr.firstIndex(of: 5) {
                selectedFilterArr.remove(at: index)
                sender.backgroundColor = UIColor.white
            }
        }
    }
    
    @IBAction func btn6(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white{
            selectedFilterArr.append(6)
            sender.backgroundColor = UIColor.green
        }else{
            if let index = selectedFilterArr.firstIndex(of: 6) {
                selectedFilterArr.remove(at: index)
                sender.backgroundColor = UIColor.white
            }
        }
    }
   
}
