# The Object Model #

## Classes Define Objects ##

classes
: the attributes and behaviors of its objects

Classes are basic outlinbes of what an object should be made of and what it should be able to do.

Defining a class has syntax similar to defining a method. We replace the `def` with `class` and use the CamelCase naming convention to create the name. We then use the reserved word `end` to finish the definition. Ruby file names should be `snake_case`, and reflect the class name.

```ruby
# good_dog.rb
class GoodDog
end

sparky = GoodDog.new
```
In the above example