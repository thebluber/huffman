# Simple Huffman Encoder/Decoder

This is a simple implementation of huffman algorithm to encode a text.

## Installation

Add this line to your application's Gemfile:

    gem 'simple_huffman'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_huffman

## Usage

#### Utilities
```ruby
require 'huffman'

#encode a text
result = Huffman.encode('This is a test!') # => {:encoded_text=>"0101010010011000100110000010000011001111011101", :code_table=>{"s"=>"11", "!"=>"101", "i"=>"100", "t"=>"011", "T"=>"0101", "h"=>"0100", "e"=>"0011", "a"=>"0010", " "=>"000"}}
result[:encoded_text] # => "0101010010011000100110000010000011001111011101"
result[:code_table] # => {"s"=>"11", "!"=>"101", "i"=>"100", "t"=>"011", "T"=>"0101", "h"=>"0100", "e"=>"0011", "a"=>"0010", " "=>"000"}

#decode a code string
code_string = "0101010010011000100110000010000011001111011101"
code_table = {"s"=>"11", "!"=>"101", "i"=>"100", "t"=>"011", "T"=>"0101", "h"=>"0100", "e"=>"0011", "a"=>"0010", " "=>"000"}
Huffman.decode(code_string, code_table) # => "This is a test!"

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
