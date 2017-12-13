//
//  RestaurantDetailViewController.swift
//  Khmer Shops
//
//  Created by Mengsroin Heng on 12/12/17.
//  Copyright © 2017 Mengsroin Heng. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var selectedRestaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.text = selectedRestaurant.description
        let imageUrl = URL(string: selectedRestaurant.logoThumbnail)!
        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    if image != nil {
                        self.logoImageView.image = image
                    } else {
                        self.logoImageView.image = #imageLiteral(resourceName: "store")
                    }
                }
            }
        }
        task.resume()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
