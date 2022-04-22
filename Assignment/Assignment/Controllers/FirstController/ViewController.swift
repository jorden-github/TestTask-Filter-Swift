//
//  ViewController.swift
//  Assignment
//
//  Created by Jorden Williams on 22/04/2022.
//

import UIKit
import Foundation
import Alamofire
import SDWebImage
import iOSDropDown
class ViewController: BaseVC {
    //MARK: - Variables
    var allData : [DataModel] = []
    var isSearchResultFound : Bool = false
    var searchIndex : Int = 0
    var filteredArray : [DataModel] = []
    var filterResultFound : Bool = false
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dataTableView: UITableView!
    //MARK: - IBActions
    
    @IBAction func filterBtnAction(_ sender: Any) {
        let vc = FilterVC.FilterVC()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func removeFilterBtnAction(_ sender: Any) {
        if filterResultFound{
            self.filterResultFound = false
            if searchBar.text != ""{
                self.isSearchResultFound = true
            }
            self.dataTableView.reloadData()
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showHud(vc: self)
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        DataModel.getAllCustomers { [weak self] result in
            guard let self = self else{return}
            self.hideHud(vc: self)
            self.allData = result
            self.dataTableView.reloadData()
            print("success")
        } failure: { error in
            print("failure")
        }
        
    }
    //MARK: - Functions

}

//MARK: - TableView Extension
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchResultFound || filterResultFound{
            return filteredArray.count
        }else{
            return allData.count
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CharacterDetailsVC.CharacterDetailsVC()
        if isSearchResultFound{
            vc.charactersData = filteredArray[indexPath.row]
        }else if filterResultFound{
            vc.charactersData = filteredArray[indexPath.row]
        }else{
            vc.charactersData = allData[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableCell", for: indexPath) as! DataTableCell
        if isSearchResultFound{
            cell.characterDetails.text = filteredArray[indexPath.row].name
             let url = URL(string: filteredArray[indexPath.row].img)
            cell.characterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "dummyimage"), options: .highPriority, progress: nil, completed: { (image, error, type, url) in
                if(error != nil){
                    cell.isUserInteractionEnabled = true
                    cell.characterImageView.image = UIImage(named: "dummyimage")
                }else{
                    cell.isUserInteractionEnabled = true
                    cell.characterImageView.image = image
                }
            })
        }else if filterResultFound{
            cell.characterDetails.text = filteredArray[indexPath.row].name
             let url = URL(string: filteredArray[indexPath.row].img)
            cell.characterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "dummyimage"), options: .highPriority, progress: nil, completed: { (image, error, type, url) in
                if(error != nil){
                    cell.isUserInteractionEnabled = true
                    cell.characterImageView.image = UIImage(named: "dummyimage")
                }else{
                    cell.isUserInteractionEnabled = true
                    cell.characterImageView.image = image
                }
            })
        }else{
            cell.characterDetails.text = allData[indexPath.row].name
             let url = URL(string: allData[indexPath.row].img)
            cell.characterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "dummyimage"), options: .highPriority, progress: nil, completed: { (image, error, type, url) in
                if(error != nil){
                    cell.isUserInteractionEnabled = true
                    cell.characterImageView.image = UIImage(named: "dummyimage")
                }else{
                    cell.isUserInteractionEnabled = true
                    cell.characterImageView.image = image
                }
            })
        }
        return cell
    }
    
    
}
//MARK: - UISearchBarDelegate Delegate
extension ViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredArray.removeAll()
        if filterResultFound{
            filterResultFound = false
            self.dataTableView.reloadData()
        }
        
        if searchText == ""{
            self.isSearchResultFound = false
            self.dataTableView.reloadData()
        }else{
            for data in allData{
                if data.name.contains(searchText){
                    self.filteredArray.append(data)
                }
            }
            self.isSearchResultFound = true
            self.filterResultFound = false
            self.dataTableView.reloadData()
        }
    }
   
}
//MARK: - FilterVC Delegate
extension ViewController : FilterVCDelegate{
    func getFilteredData(selecAppearances: [Int]) {
        self.filteredArray.removeAll()
        for data in allData{
           let val = data.appearance.filter(selecAppearances.contains(_:))
            print(val)
            if val.count > 0 {
                filteredArray.append(data)
            }
        }
        print("These are filtered:\(filteredArray.count)")
        self.isSearchResultFound = false
        self.searchBar.text = ""
        self.filterResultFound = true
        self.dataTableView.reloadData()
    }
}
