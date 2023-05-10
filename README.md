# README
This is a small project designed to mimic an [API gateway](https://www.nginx.com/resources/glossary/api-gateway/).

### Functionality
The initial scope of this project is quite small:
- All requests to the app will be routed to a single endpoint
- A `yml` file will contain a mapping of recognised routes (likely to be replaced by some sort of database)
- A single controller will interface with the `yml` file, transform the request and then make that request to https://dummyjson.com/
- Where requests are not recognised, a default endpoint will be used
- Hopefully I'll be able to deploy this to the Cloud

### Design Choices
It would have been cleaner to use Sinatra (far less cruft), but I've written this in Rails because I want to explore some of the more quirky parts of Rails I don't get to interact with in my day job. 

I don't intend to take advantage of all of the routing features - in fact, most of that is not necessary for this project.
