# String Mapper

String Mapper is an extension of the String class to perform conversions based on dynamic mappings. 

## Requirements

String Mapper uses ActiveSupport's `cattr_accessor`.

## Howto  

Class function `add_mapper` allows the definition of a new target for conversions. For example, the call:

    String.add_mapper :model

adds an instance method `to_model` to convert any String to something called "model". It also adds a class hash called `model_mappings` which can be used to define mappings:

    String.model_mappings[/usuari[oa]$/i] = User
    'Usuario'.to_model # => User class  

Optionally we can define the mappings adding the mapper:

    String.add_mapper :model, {
      /usuari[oa]$/i  => User,
      /cat[áa]logo$/i => Catalog }
    'Usuario'.to_model # => User class  
    'Person'.to_model  # => nil

Also a block can be given to `add_mapper` to manage the default value when no mapping matches the string:

    String.add_mapper(:number) { |string| string.to_i }
    String.number_mappings = {
      /an?$/i => 1,
      /two$/i => 2 }
    'an'.to_number   # => 1  
    'two'.to_number  # => 2  
    '1000'.to_model  # => 1000

Other use examples can be found in `spec/string-mapper_spec.rb`.


## AUTHOR

Copyright 2008, Fernando García Samblas <fernando.garcia at the-cocktail.com>

See COPYING file for licensing details.

