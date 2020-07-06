# deta_pack

A package for using deta Base features easily from within your flutter packages.

## Getting Started :

This simple package is built with the aim to simplify using deta base features of deta.sh from your flutter apps.
Currently, all commands given by the http API of base are available.

## Installation :

To use <b>deta_pack</b> in your projects, add the following line to your <a>pubspec.yaml</a> file.
<code>
dependencies:
    deta_pack: ^0.1.0
</code>
After that, issue the pub get command.
Then use the following to import it into your file :
<code> import 'package:deta_pack/deta_pack.dart';</code>

## Usage :
To use base features, you need to know your project ID and your API key for the project.
Head over to (deta.sh)[http://deta.sh] to get started.
> You need both project Id and the API key to talk with your deta base. Head over to (deta.sh)[deta.sh] to get yours

Once you have your API key and your project Id, create an object of the class detaBase.
<code>var base = detaBase(apiKey,projectId);</code>
This initializes the object with your key and project ID.

A simple example to demonstrate reading data from from your base :
> Important : Do not share your API key with anyone.This will let them get all your data.

<code>
String apiKey = "a0abcyxz_aSecretValue";                   // Your API Key here. Remember, TOP SECRET!
String projectId = "randomId";                             // Your project ID
String baseName = "myBase";                                // Name of the base (database)
var base = detaBase( apiKey , projectId );                 // Initialising an object with the apiKey and project ID

var response = base.getData( baseName , 'one' );           // Getting the element with key 'one'
response.then( ( res ) => { print( res.body ) } );         // Prints the response to the adb/ terminal 
</code>
The getData() method returns a Future instance, which will resolve into a response object once the HTTP request is completed.
The response returned is an object of the Response class from the HTTP Package. response.body  contains the response JSON, as specified in Deta HTTP API documentation.

## Reference :

#### Future<Response> getData( String baseName, String key )
This method lets you get data from your base.
This method takes in two arguments, the name of the base and the key of the data to get. 
 Consider the base has the following data in it:
<code>
{
"key":"one",
"name":"kakashi",
"country":"Japan"
},
{
"key":"two",
"name":"Harris",
"country":"India"
}
</code>
Then,
<code>
var response = base.getData( baseName , 'one' );           // Getting the element with key 'one'
response.then( ( res ) => { print( res.body ) } ); 
</code>
will print the following to your adb/ terminal 
<code>
{
"key":"one",
"name":"kakashi",
"country":"Japan"
}
</code>


#### Future<Response> putData( String baseName, String items )
This method let's you put new data items to your base. The 'items' argument is a string in JSON format.
This method takes two arguments, onr the bse to put data into and then the list of items to be put in to the base.
<code>
// Example item
/* {
"key":"one",
"name":"kakashi",
"country":"Japan"
}
*/
// Corresponding item string 
String itm = '{ "key":"one" , "name":"kakashi", "country":"Japan" }';

// Incase of multiple items, construct the items string with commas seperating each item
/* 
{
"key":"one",
"name":"kakashi",
"country":"Japan"
},
{
"key":"two",
"name":"Harris",
"country":"India"
}
*/
// The above list of items should be put in a string as shown below.
String itm2 = '{ "key":"one", "name":"kakashi", "country":"Japan" },{ "key":"two", "name":"Harris", "country":"India" }'

var response = base.putData( baseName, itm );
response.then( (res)=>{ print(res.body) } );
</code>

#### Future<Response> deleteData( String baseName, String key )
This method is for deleting data objects from the base.
This method takes two arguments, the base name and the key of the item to be deleted.
<code>
var response = base.deleteData( baseName, 'one' );    // This operation deletes the item with key 'one' from the base.
response.then( (res)=>{ print(res.body) } );
</code>

#### Future<Response> insertData( String baseName , String  item )
This method adds an item to the base if the key does not already exist, i.e. creates a new item only if an item with the same key does not already exist.
This method takes in two arguments, baseName and the item to be inserted. Only single items can be inserted.
<code>
String itm = '{ "key":"three" , "name":"Hinata", "country":"Japan" }';
var response = base.insertData( baseName , itm );
response.then( ( res ) => { print(res.body) } );  // The response body contains the item inserted if the operation was successful.
</code>

#### Future<Response> updateData( String baseName , String key, String update, String delete )
This method lets you update specific fields of an existing item and also delete specific fields from the item.
This method takes in four arguments, baseName, the key of the item to be modified, update string containing the data to be updated and
the delete string containing the field to be deleted from the item.
 <code>
 // The update string contains an JSON string, containing the values to be modified.
 // The delete string contains a string with the name of fields to be deleted, separated by commas.
 // Consider that you want to modify the name and delete the country and age fields of the item with key 'two',
 /*
 Let this be the item before update.
 {
 "key":"two",
 "name":"Harris",
 "age":100,
 "country":"India"
 }
 */ 
 String update = '{"name":"naruto"}';
 String delete = '"country","age"';
 var response = base.updateData( baseName, 'two', update, delete);
 response.then( ( res ) => { print( res.body ) } );    // Body contains the request made. i.e fields updated and the fields deleted.
 </code>
 
 #### Future<Response> queryData(String base, String queries, {int limit, String last})
 This method lets you query data from the base. i.e. gets you data that matches given queries.
 This method takes four arguments, the base name, the query string, 
 Optional parameters are limit( max the number of items to be listed that match the query ) and the 'last' key that was listed in the previous query.
<code>
 // The query string contains an JSON string, containing the queries.
 // Consider that you want to query and get all items in the bases with the name 'kakashi'
 /*
 Let this be the item.
 {
 "key":"one",
 "name":"kakashi",
 "country":"Japan"
 }
 */ 
 String query = '{"name":"naruto"}';
 var response = base.updateData( baseName, query);
 response.then( ( res ) => { print( res.body ) } );    // Body contains items that match the query.
 </code> 
 
 
> This package is in active development and will certainly get more features and functions soon. If you have any feature requests, please use the github repo,
> (click here to go to github)[https://github.com/aloysiousBenoy/deta_pack].
> If you have a feature request, add it to the feature_request file in the repo and create a pull request. 
> Please report any and all bugs using issues in github.

