# Classes and Objects #

- [Objects](#objects)
- [Classes](#classes)
- [Object Instantiation](#initializing-a-new-object)
- [Instance Variables](#instance-variables)
- [Instance Methods](#instance-methods)
- [Class Variables](#class-variables)
- [Class Methods](#class-methods)

## Objects ##

In Ruby, anything that has a **value** can be considered an **object**. Numbers, strings, arrays, clases and modules are all considered to be *objects*. Methods, blocks, and variables *are not objects*.

```ruby
# objects
'hi'.is_a?(Object)
20.is_a?(Object)
['1', 2, :3, nil].is_a?(Object)
Hash.new.is_a?(Object)

module Readable
  def what_am_i
    puts 'You're a wizard (read: Object), Harry!"
  end
end

class Wizard
  include Readable
end

Readable.is_a?(Object)
Wizard.is_a?(Object)
harry = Wizard.new
harry.is_a?(Object)
harry.what_am_i
```

Objects are created from **classes** (which are another type of Object)

*Class*
: a blueprint

*Object*
: something built from that blueprint

Individual object can contain different information, but can still be instances of the same class.

```ruby
str1 = "I am a String object"
str2 = "I am a different String object"

puts str1.class
puts str2.class
puts str1
puts str2
```

## Classes ##

## Object Instantiation ##

## Instance Variables ##

## Instance Methods ##

## Class Variables ##

## Class Methods ##
