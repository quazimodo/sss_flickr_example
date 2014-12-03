Flickr API Example Application
==============================

An example application consuming the Flickr API to perform simple image searching.

# Important Notes

## The .env file

Because environment variables are used for the flickr api keys, I'm using dotenv gem to keep track of them. Naturally the .env file used by dotenv is not part of the repository, and so in order to turn the app on in dev you'll need to provide a .env file in the app root folder;

```
FLICKR_API_KEY=<the key>
FLICKR_API_SECRET=<the secret>
````

## Mobile support/UI

Acknowledging that mobile readiness and UI are critical to a good web application, this app is more of an example of back end code.

# Example App
https://sss-flickr-example.herokuapp.com


# Thoughts

The requirements of the project asked for an app that queried flickr, returned a list of photos and some pagination links.

This is simple enough to do, however because we are consuming an external service there are issues with blocking and timeouts. There are a number of ways to solve this, for example asynchronous responses/streaming, 'your content is being loaded please wait' pages, etc.

However it was not a feature that was asked for and for a simple application with limited users it is fairly unnecessary.


Aside from that, the internal FlickrSss service could be improved a little bit, however I believe that in it's bare form the Base#send_request method makes it easy enough for a diligent coder to consume the flickr service manually, parse the XML and do whatever they need to do.