//
//  TableViewController.swift
//  metmuseum
//
//  Created by Kamila Sultanova on 10.08.2023.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import SDWebImage

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchbar: UISearchBar!
    var arrayArt: [Arts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        tableView.dataSource = self
//        tableView.delegate = self
        searchbar.delegate = self
        searchbar.placeholder = "Enter name of art or an artist"
     
        searchArtist(keyword: "Vincent van Gogh")
//        searchArtist(keyword: "Leonardo")
    
    }
    

    func searchArtist(keyword: String) {
        
        //
        SVProgressHUD.show()

        let parameters = ["q": keyword]
        
        AF.request("https://collectionapi.metmuseum.org/public/collection/v1/search", method: .get, parameters: parameters).responseData { response in
            
            SVProgressHUD.dismiss()
            
            if let data = response.data {
                let json = JSON(data)
                
                if let objectIDs = json["objectIDs"].arrayObject as? [Int] {
                    
                    self.arrayArt.removeAll()
                    
                    for (index, objectID) in objectIDs.prefix(15).enumerated() {
                    self.getObjectDetails(objectID: objectID, isLastItem: index == 14)
                    }
                    
                }
            }
        }
        
    }
    
    func getObjectDetails(objectID: Int, isLastItem: Bool) {
        
        
        AF.request("https://collectionapi.metmuseum.org/public/collection/v1/objects/\(objectID)", method: .get).responseData { response in
            if response.response?.statusCode == 200 {
                var resultString = ""
                if let data = response.data{
                    resultString = String(data: data, encoding: .utf8)!
                    print(resultString)
                }
                
                if response.response?.statusCode == 200 {
                    let json = JSON(response.data!)
                    
                    let art = Arts(json: json)
                    self.arrayArt.append(art)
                    
                    if isLastItem {
                    self.tableView.reloadData()
                    }
                }
            }
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        arrayArt.removeAll()
        tableView.reloadData()
        searchArtist(keyword: searchBar.text!)
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayArt.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtCell", for: indexPath) as! ArtTableViewCell
        
        // Configure the cell...
        
        cell.setData(newArt: arrayArt[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360.0    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        vc.art = arrayArt[indexPath.row]
        
        navigationController?.show(vc, sender: self)
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
