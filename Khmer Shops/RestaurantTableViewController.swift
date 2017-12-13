//
//  RestaurantTableViewController.swift
//  Khmer Shops
//
//  Created by Mengsroin Heng on 12/11/17.
//  Copyright © 2017 Mengsroin Heng. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RestaurantTableViewController: UITableViewController {

    var restaurants = [Restaurant]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0)
        
        let searchBar = UISearchBar(frame: frame)
        searchBar.sizeToFit()
        searchBar.placeholder="Search restaurant"
        searchBar.barStyle = .default
        tableView.tableHeaderView = searchBar
        
        loadRestaurantFromFirebase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_restaurant", for: indexPath) as! RestaurantTableViewCell
        let restaurant = restaurants[indexPath.row]
        cell.nameLabel.text = restaurant.name
        cell.locationLabel.text = restaurant.description
        print("Load image from url: ", restaurant.logoThumbnail)
        let imageUrl = URL(string: restaurant.logoThumbnail)!
        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    if image != nil {
                        cell.logoImageView.image = image
                    } else {
                        cell.logoImageView.image = #imageLiteral(resourceName: "store")
                    }
                }
            }
        }
        task.resume()
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */





    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let restaurantDetailViewController = segue.destination as! RestaurantDetailViewController
        let selectedCell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: selectedCell)!
        let article = restaurants[indexPath.row]
        restaurantDetailViewController.selectedRestaurant = article
    }
 

    
    func loadRestaurantFromFirebase(){
        let courseRef = Database.database().reference(withPath: "restaurant")
        courseRef.observe(.value, with: { (dataSnapshot) in
            print("There's sth changed on course node")
            self.restaurants.removeAll()
            for restaurantSnapshot in dataSnapshot.children.allObjects as! [DataSnapshot] {
                let restaurantDict = restaurantSnapshot.value as! [String:Any]
                
                // Fetch all properties from json object
                //let id = restaurantDict["id"] as! Int
                let name = restaurantDict["name"] as! String
                let description = restaurantDict["description"] as! String
                let logoUrl = restaurantDict["logo_url"] as! String

                // Combine all properties into course object
                let restaurant = Restaurant(name: name, description: description, logoThumbnail: logoUrl)
                self.restaurants.append(restaurant)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
}
