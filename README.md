# MaPreference
LighthouseLabs.ca iOS Bootcamp - MIDTERM PROJECT: Crowd sourced preferred breastfeeding locations map app 

Using Parse Framework, users first sign up and then log in to view the map. If already logged in, they are forwarded to the map, bypassing the log in view. The map displays all locations within 2.0Km. On the map navigation bar a user can tap a button which will toggle a list view. The list view displays all locations within 2.0Km in a table view. Each table cell displays the name, address, and the distance from the user's current location. 

![MaPreference Signup](MaPreference-signup.gif)

Tapping an item in the list will forward the user to the detail view for that location. On the map tapping a pin will display a callout containing the name and address of the location. Tapping the callout will forward the user to the detail view for the location. New locations can be added from either the map or the "List Locations" table view. 

![MaPreference Login and Map](MaPreference-loginmapandlist.gif)

On the detail view users are able to see the name and address of the location as well as any reviews / comments that have been added by other users. From the detail view users can add a new review. The new review will appear at the bottom of the review list.

![MaPreference Details and Add Review](MaPreference-detailandaddreview.gif)

********
This was a midterm project with limited time, as such the UI and UX are very basic. Additionally reverse geocoding the address of a new location added by a user was not implemented. Added location pins are created based on the user's current location when adding. This will be fixed if development continues on this app.
