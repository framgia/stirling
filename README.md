# Stirling [![Build Status](https://travis-ci.org/framgia/stirling.svg)](https://travis-ci.org/framgia/stirling) [![Gem Version](https://badge.fury.io/rb/stirling.svg)](http://badge.fury.io/rb/stirling)
Stirling provides some architectures for Rails to develop quickly.

## Usage
Add to your Gemfile.

```ruby
gem "stirling"
```
## Functions
### BaseController
BaseController automatically creates instance variable corresponding to controller name. For example:

```
UserController -> @user
```

and assigns parameter to instance variable.

### Re-create db task
Stirling provides command to re-create db like following.

```
$ rake db:recreate
```

## Strong Parameters
In Stirling, accepting attributes is handeled to use `acceptable_attributes`, class method in model. You have to do like following.

```ruby
class User < ActiveRecord::Base
  class << self
    def acceptable_attributes
      [:name, :age, :email]
    end
  end
end
```

`acceptable_attributes` is inserted automatically in model if you generate to use `rails g model MODEL_NAME`.

## Copyright
This project rocks and uses MIT-LICENSE.
