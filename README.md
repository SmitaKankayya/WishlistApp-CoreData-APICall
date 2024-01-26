# WishlistApp-CoreData-APICall
The app allows users to toggle between viewing wishlist items stored in a local database and fetching data from an API.

The following steps outline the functionality of the app:

* 		Homepage:
    - Display a toggle button (switch) on the homepage, positioned above a UICollectionView.
      
    - The switch is ON by default.
      
* 		Toggle Functionality:
    
    - When the switch is ON, wishlist items are shown, loaded from the local database.
    
    - When the switch is OFF, data is fetched from the API: https://jsonplaceholder.typicode.com/users.
      
* 		API Data Processing:
   
    - Parse the JSON data received from the API.

* 		CollectionView Display:
    
    - Populate the UICollectionView with the parsed data.
    
    - Design a custom cell containing product title and price.

* 		Cell Selection:
    
    - On selecting a cell, navigate to the next view.
    
    - Display all the details from api.
   
    - Include a Wishlist button.
      
* 		Wishlist Management:
   
    - On Wishlist button click, save data to the local database.
   
    - Allow users to go back.
      
This repository serves as a comprehensive Xcode project for an iOS Wishlist App with seamless integration of local database storage, API data fetching, and an intuitive user interface. 



