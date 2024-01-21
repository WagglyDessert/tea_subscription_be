 # Take_Home_BE

This is my mod4 prework practice at Turing. It is a refresher practice application that involves subscribing a customer to a tea subscription, cancelling that subscription, and being able to see all of a customer's subscriptions.

## Learning Goals

- A strong understanding of Rails
- Ability to create restful routes
- Demonstration of well-organized code, following OOP
- Test Driven Development
- Clear documentation

### Prerequisites

- Ruby (version 7.0.8 or later)
- Bundler (`gem install bundler`)

### Installation

1. Clone the repository.

```
git clone git@github.com:WagglyDessert/tea_subscription_be.git
```

2. Install Dependencies

```
bundle install
```

3. Set database

```
rails db:{drop,create,migrate,seed}
```


### Running the tests
  -RSpec is setup so all you need to do is run:

```
Bundle exec rspec
```

### Happy Path Endpoints
1. Subscribe a customer
Endpoint: `/api/v0/customer_subscriptions`
Description: Retrieve current weather information.
Example Request:
```
bash
curl -X GET https://your-api-base-url/api/v0/customer_subscriptions
```
Remember to include the post params in the request

2. Delete a customer from a subscription
Endpoint: '/api/v0/customer_subscriptions/#{customer_subscriptions.id}'
Description: Search for restaurants based on location.
Example Request:
```
bash
curl -X GET https://your-api-base-url/api/v0/customer_subscriptions/#{customer_subscriptions.id}
```

3. Show a list of a customer's subscriptions
Endpoint: '/api/v0/customers/#{customer.id}'
Description: Delete a customer from a subscription, but subscription still exists.
Example Request:
```
bash
curl -X GET https://your-api-base-url/api/v0/customers/#{customer.id}
```

### Release History
* 0.0.1
  * work in progress

### Authors
  * Nathan Trautenberg

### License
[This project is licensed under the MIT License.](https://www.mit.edu/~amini/LICENSE.md)
