Flickr API Example Application
==============================

An example application consuming the Flickr API to perform simple image searching.

* Important Note - the .env file

Because environment variables are used for the flickr api keys, I'm using dotenv gem to keep track of them. Naturally the .env file used by dotenv is not part of the repository, and so in order to turn the app on in dev you'll need to provide a .env file in the app root folder;

```
FLICKR_API_KEY=<the key>
FLICKR_API_SECRET=<the secret>
````

* Example App
[https://sss-flickr-example.herokuapp.com]

