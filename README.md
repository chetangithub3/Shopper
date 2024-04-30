#  Shoppers Stop



Required Capstone App Functionality Needed to Pass

DONE:
----
We suggest using Xcode 14.3 or 14.3.1 and iOS 16.x, or Xcode 15 and iOS 17.
------> Done Xcode 15 and iOS 17



The app has a README file, including a basic explanation of the app and explanations of how your app fulfills each rubric item. Identify your features and any specific file names so your mentor doesn’t have to search for them while grading.
------>Done


The app does not use any third-party frameworks or packages.
------>Done

The app has a launch screen suitable for the app. 
It can be either a static or animated launch screen.
------>Done     Launch Screen.storyboard



The app has at least one screen with a list using a view of your choice (List, Grid, ScrollView etc). This list should appear in a tab view with at least two tabs.
------>Done     HomeView.swift


Each item in the list should contain (at minimum) a name, a subtitle or description, and an image of the item, and any text should be styled appropriately. 
------>Done     Product Details (image, title, cost)


Tapping an item in this list should navigate (NavigationStack)  to a detail view: This should show the same data in the list item with some further details such as a longer description, bigger picture, price, or a Buy/Order button. 
------>Done     ProductDetailView

Include enough items to ensure that the user has to scroll the list to see all the items in it. 
------>Done     HomeView.swift


The app has one or more network calls using URLSession to download/upload data related to the core tasks of the app. The app’s repo does not contain API keys or other authentication information. Don’t store API keys or other authentication information in your app’s repo. See this article to store them in a plist, add the plist to your .gitignore file, then attach the plist to your Google doc.

------>Done     Fetching products on OnboardingView;  Fetching Images using ImageLoader 

If your API has a low request limit that your mentor might hit, highlight this in the README and explain how to use your freeze-dried data.
------>None   


The app handles all typical errors related to network calls — including server error response codes and no network connection — and keeps the user informed.  
------>Done    Handled No internet issue

The app uses at least one way to save data: user defaults, plist, file, or keychain. Specify your method in the README.
------>Done    Used UserDefauls and SwiftData


The app uses Swift Modern Concurrency, async/await, and MainActor appropriately to keep slow-running tasks off the main thread and to update the UI on the main thread. No dispatch queues or completion handlers
------>Done   


The app communicates to the user whenever data is missing or empty, the reason for that condition — for example, data cannot be loaded, or the user hasn’t created any — and the action the user should perform to move forward. The app should have no blank screens, and the user should never feel “lost”. 
------>Done    when Cart is empty 

All included screens work successfully without crashes or UI issues. 
------>Done  


Views work for landscape and portrait orientations for the full range of iPhone sizes, including iPhone SE 2.
------>Done  


Views work for both light and dark modes.
------>Done

There are no obvious UI issues, like UI components overlapping or running off the screen.
------>Done  

The code should be organized and easily readable.
------>Done  


Project source files are organized in folders such as Views, Models, Networking etc.
------>Done  

View components are abstracted into separate Views and source files.
------>Done  

The project uses MVVM architecture: The Model includes at least one ObservableObject with at least one Published value that at least one view subscribes to. Networking code is in a Service struct or class that can be instantiated by an ObservableObject.
------>Done  


The app builds without Warnings or Errors. (Move your TODO warnings to a different branch.)
------>Done  

The app includes:
A custom app icon.
------>Done  
An onboarding screen.
------>Done  
A custom display name.
------>Done  
At least one SwiftUI animation.
------>Done  
Styled text properties. SwiftUI modifiers are sufficient.
------>Done  





TODO:
-----


The project utilizes SwiftLint with Kodeco’s configuration file. Follow the instructions in the Kodeco Swift style guide to install it with Homebrew and the Build Run Script Phase. Don’t install it as a package. If you disable any rule for a line of code, explain why in a comment near the disable comment or, if it’s a general situation, explain in the README.  
------>To Do  

The project has a test plan including both UI and unit tests, with a minimum of 50% code coverage, and all tests succeed. Make sure your test plan is in your repo.
------>To Do  
