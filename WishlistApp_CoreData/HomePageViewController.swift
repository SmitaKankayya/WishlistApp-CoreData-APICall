//
//  HomePageViewController.swift
//  WishlistApp_CoreData
//
//  Created by Smita Kankayya on 25/01/24.
//

import UIKit
import CoreData

class HomePageViewController: UIViewController {
    
    var users : [User] = []
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var usersCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXibWithCollectionView()
        initilizeCollectionView()
        retreiveDataFromDb()
    }
    
    @IBAction func mySwitch(_ sender: UISwitch) {
        if(sender.isOn){
            retreiveDataFromDb()
        }else{
            fetchDataFromAPI()
        }
    }
    
    func retreiveDataFromDb(){
        var results : [User] = []
        guard let appDelegate = (UIApplication.shared.delegate) as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do{
            let result =  try manageContext.fetch(fetchRequest) as! [NSManagedObject]
            for eachResult in result {
                results.append(User(name: eachResult.value(forKey: "name") as? String ?? "",
                                    username: eachResult.value(forKey: "username") as? String ?? "",
                                    email: eachResult.value(forKey: "email") as? String ?? "",
                                    address: Address(city: eachResult.value(forKey: "city") as? String ?? "",
                                                     geo: Geo(lat: (eachResult.value(forKey: "lat") as? String ?? "") ,
                                                              lng: (eachResult.value(forKey: "lng") as? String ?? "") ))
                                   )
                )
            }
            self.users = results
            self.usersCollectionView.reloadData()
        }catch{
            print("error")
        }
    }
    
    func registerXibWithCollectionView(){
        let uiNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        usersCollectionView.register(uiNib, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func initilizeCollectionView(){
        usersCollectionView.dataSource = self
        usersCollectionView.delegate = self
    }
    
    func fetchDataFromAPI(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        let urlRequest = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let jsonDecoder = JSONDecoder()
            self.users = try! jsonDecoder.decode([User].self, from: data!)
            print(self.users)
            
            DispatchQueue.main.async {
                self.usersCollectionView.reloadData()
            }
        }
        dataTask.resume()
    }
}

//MARK : UICollectionViewDataSource
extension HomePageViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = self.usersCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell
        collectionViewCell?.name.text = users[indexPath.row].name
        collectionViewCell?.userName.text = users[indexPath.row].username
        collectionViewCell?.email.text = users[indexPath.row].email
        collectionViewCell?.city.text = users[indexPath.row].address.city
        collectionViewCell?.latitude.text = users[indexPath.row].address.geo.lat
        collectionViewCell?.longitude.text = users[indexPath.row].address.geo.lng
        
        collectionViewCell?.layer.borderWidth = 1
        collectionViewCell?.layer.borderColor = UIColor.black.cgColor
        collectionViewCell?.backgroundColor = .orange.withAlphaComponent(0.5)
        
        return collectionViewCell!
    }
    
}

//MARK : UICollectionViewDelegate
extension HomePageViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailViewController.usersDetailsContainer = users[indexPath.item]
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}

//MARK : UICollectionViewDelegateFlowLayout
extension HomePageViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: usersCollectionView.bounds.width, height: 210)
    }
    
}
