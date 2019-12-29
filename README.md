# SkyApp

The idea of the architecture is that I supposed that I am putting the architecture of a big product with multiple applications. 
Every layer could be an external module that can be reused in multiple applications without need to rewrite the code. (Example: B2B applications).

SkyApp is consists of :-

1-	AppLayer :- Responsible for the features at the application
•	MVVM design battern is used to avoid massive controllers.
•	Routing battern is used to move the navigation responsibility from the controller to the router.
•	Dependency injection is used at view controllers, view models, and models.
•	I did not have time to write unit tests for the applayer but I used dependency injection to make it testable.


2-	NetworkLayer (Unit tested) :- Responsible for the HTTP Requests
•	Unit tests are written with full code coverage.                                                                      

•	It is designed to be a simple network layer that serve the app.

•	It uses protocol oriented programming and dependency injection therefore it is testable.

•	It can be extendable using open closed principle, for example: interceptors can be added easily to intercept both request and response.


3-	StorageLayer :- Responsible for Database (CoreData at our app)
•	It is injected into application using its protocol.
•	User can easily change the type of storage without need to change any code at application layer, he only has to implement    the interface of storage layer.
• Coredata is used to provide an object-oriented interaction with Database.


4-	APIManager :- Responsible for All APIS at the app
•	Generics are used to give the api the request and the response during the initialization.
•	BaseAPI is used to implement the shared functions and properties between all apis like base url and access key.
•	Every api will inherit base layer should provide its url and http method.


5-	DTO :- Resposible for all APIs' request and response model
•	 It contains all requests and responses DTOs that confirms to the Encodable and Decodable protocol.


Challenges :-

1-	How to get the current location weather and the Database cities weather at the same time?
-	Using dispatch group, current location and saved cities weather are got at the same time and after those two operations are  finished, main thread is notified to update the UI.

2-	How to get the updated weather of saved cities and avoid race conditions problem?
-	Using barrier, barrier avoid many threads to write at the array at the same time
-	dispatch group is used to get all the cities updated data first and then update the main thread.

3-	How to avoid copying the massive cities list and save memory? 
-	Using Copy on write mechanism, apple uses this mechanism into array. 
 



