//
//  CharacterDetailsVC.swift
//  Assignment
//
//  Created by Jorden Williams on 22/04/2022.
//

import Foundation
import UIKit
class CharacterDetailsVC : BaseVC{
    //MARK: - Variables
    var charactersData : DataModel?
    //MARK: - IBOutlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var occupationLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var nickNameLbl: UILabel!
    @IBOutlet weak var seasonAppearanceLbl: UILabel!
    
    //MARK: - Class Functions
    class func CharacterDetailsVC()-> CharacterDetailsVC{
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharacterDetailsVC") as! CharacterDetailsVC
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        if let data = charactersData{
            let url = URL(string: data.img)
            self.characterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "dummyimage"), options: .highPriority, progress: nil, completed: { [weak self] (image, error, type, url) in
                guard let self = self else{return}
                if(error != nil){
                    self.characterImageView.image = image
                }else{
                    print("Error")
                }
            })
            self.nameLbl.text = data.name
            
            self.occupationLbl.text = getOccupation(occupations: data.occupation)
            self.statusLbl.text = data.status
            self.nickNameLbl.text = data.nickname
            self.seasonAppearanceLbl.text = getAppearance(appearences: data.appearance)
            
        }
    }
    func getOccupation(occupations : [String])-> String{
        var allOccupations : String = ""
        for i in 1...occupations.count{
            if i != occupations.count{
                allOccupations.append("\(occupations[i - 1]),\n")
            }else{
                allOccupations.append("\(occupations[i - 1])")
            }
        }
        return allOccupations
    }
    func getAppearance(appearences : [Int]) -> String{
        var allAppearences : String = ""
        if appearences.count > 0{
            for i in 1...appearences.count{
                if i != appearences.count{
                    allAppearences.append("\(String(appearences[i - 1])),\n")
                }else{
                    allAppearences.append((String(appearences[i - 1])))
                }
            }
        }
        return allAppearences
    }
}
