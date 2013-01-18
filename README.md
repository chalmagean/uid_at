# UidAt

Simple gem to verify the UID against the Austrian https://finanzonline.bmf.gv.at API.

## Installation

Add this line to your application's Gemfile:

    gem 'uid_at'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uid_at

## Usage

You should overwrite the authentication info in an initializer file `config/initializers/uid_at.rb`:

```
UidAt.subscriber_id = "<Your SubscriberID>"
UidAt.user_id = "<Your UserId>"
UidAt.pin = "<Your Pin>"
UidAt.uid = "<Your UID>"
```

Here's how you can use it:

```
v = UidAt::Validator.new("ATU64968899") 
v.valid?
=> true
v = UidAt::Validator.new("xxx") 
v.valid?
=> false
v = UidAt::Validator.new("ATU64968899") 
v.get_details
=> all company details needed (name, address)
```

## ToDo

1. Parse error Codes returned from Finanzonline


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
