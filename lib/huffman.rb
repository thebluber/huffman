class Node
  attr_accessor :value, :weight, :left, :right, :order
  def initialize(value, weight, order=0, left=nil, right=nil)
    @value = value
    @weight = weight
    @left = left
    @right = right
    @order = order #actuality of the node
  end

  def traverse(code, hash)
    if leaf?
      hash[@value] = code
    else
      @left.traverse(code + '1', hash)
      @right.traverse(code + '0', hash)
    end
  end

  #the sorting order should be defined by weight and order of the internal node
  #for obtaining Huffman code with minimum variance the most recent internal node should be later in the list
  def <=>(other)
    if @weight < other.weight
      -1
    elsif  @weight > other.weight
      1
    else
      if @order < other.order
        return -1
      elsif @order > other.order
        return 1
      end
      0
    end
  end

  def leaf?
    @left.nil? && @right.nil?
  end
end

class Huffman
  # frequencies should be a hash containing the occuring letters of the text and their corresponding frequency
  # i.e. {'a' => 5, 'b' => 3}
  def self.encode(text, frequencies=nil)
    frequencies = get_frequencies(text) unless frequencies
    tree = build_tree(frequencies)
    code_table = {}
    frequencies.size > 1 ? tree.traverse('', code_table) : code_table = {frequencies.keys[0] => '0'}
    {encoded_text: text.chars.map{|char| code_table[char]}.join, code_table: code_table}
  end

  def self.decode(encoded_text, code_table)
    text = []
    code_table = code_table.invert
    previous = ''
    encoded_text.each_char do |char|
      if code_table[previous + char]
        text << code_table[previous + char]
        previous = ''
      else
        previous += char
      end
    end
    text.join
  end

  private
  def self.get_frequencies(text)
    frequencies = Hash.new(0)
    text.each_char do |char|
      frequencies[char] += 1
    end
    frequencies
  end

  def self.build_tree(frequencies)
    nodes = []
    frequencies.each_pair do |letter, frequency|
      nodes << Node.new(letter, frequency)
    end

    order = 1
    while nodes.length > 1 do
      nodes.sort!
      left = nodes.shift
      right = nodes.shift
      combined = Node.new('', left.weight + right.weight, order, left, right)
      nodes << combined
      order += 1
    end
    nodes.shift
  end

end
