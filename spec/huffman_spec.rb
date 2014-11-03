require 'spec_helper'

describe Node do

  before do
    @node1 = Node.new('', 10)
    @node2 = Node.new('', 2, 1)
    @node3 = Node.new('', 2, 2)
    @node4 = Node.new('', 3, 3)
    @node5 = Node.new('', 3)

    @tree = Node.new('', 5, 2, Node.new('a', 3), Node.new('', 4, 1, Node.new('b', 1), Node.new('c', 1)))
  end
  it 'should sort by weight and order' do
    expect([@node1, @node5].sort).to eql([@node5, @node1])
    expect([@node2, @node5, @node3].sort).to eql([@node2, @node3, @node5])
    expect([@node2, @node3].sort).to eql([@node2, @node3])
    expect([@node4, @node5].sort).to eql([@node5, @node4])
    expect([@node1, @node3, @node2, @node4, @node5].sort).to eql([@node2, @node3, @node5, @node4, @node1])
  end

  it 'should traverse the node and store the code' do
    code_table = {}
    @tree.traverse('', code_table)
    expect(code_table).to eql({'a'=>'1', 'b'=>'01', 'c'=>'00'})
  end
end

describe Huffman do

  it 'should get the frequencies of the letters from the given text' do
    expect(Huffman.send(:get_frequencies, 'abc abb d')).to eql({'a'=>2, 'b'=>3, 'c'=>1, 'd'=>1, ' '=>2})
    expect(Huffman.send(:get_frequencies, '11123')).to eql({'1'=>3, '2'=>1, '3'=>1})
  end

  it 'should encode a text correctly' do
    expect(Huffman.encode('aaaaa')[:encoded_text]).to eql '00000'
    expect(Huffman.encode('aab')[:encoded_text]).to eql '001'
    expect(Huffman.encode('abbca', {'a'=>4, 'b'=>2, 'c'=>1})[:encoded_text]).to eql '01010110'
    expect(Huffman.encode('abbca', {'a'=>3, 'b'=>2, 'c'=>1})[:encoded_text]).to eql '10000011'
    expect(Huffman.encode('abbcaa')[:encoded_text]).to eql '100000111'
    expect(Huffman.encode('ababcaa')[:encoded_text]).to eql '0100101100'
  end

  it 'should decode a text correctly' do
    expect(Huffman.decode('110110010100', {'a'=>'11', 'b'=>'01', 'c'=>'00', ' '=>'1001'})).to eql 'ab bc'
    expect(Huffman.decode('111010000111', {'a'=>'1', 'b'=>'011', 'c'=>'00', ' '=>'010'})).to eql 'aaa cba'
  end

  it 'should return the original text after decoding the given encoded text and code table' do
    text = <<-EOM
      Lorem ipsum dolor sit amet, varius ut, nunc placerat sed nulla odio nisl vitae, pede sed, massa vitae dolor adipiscing nec, eros id dictum.
      Accumsan in, morbi erat in fermentum egestas quis cillum, vivamus rhoncus vitae. Lorem donec venenatis fermentum in ut, vel etiam justo dui, magna vitae, vel eros quis, eros in sapien mollis donec consectetuer placerat.
      Donec velit in eu, nulla enim rutrum nulla nec varius aliquam, parturient et proin aenean praesent elit ornare, mauris tempor ante enim id. Sit dictum blanditiis, eros in id ullamcorper ut pellentesque imperdiet, imperdiet arcu. Id lectus voluptatem, nec consequat nulla curabitur. Nullam ipsum nisl, mi turpis, pariatur id non wisi ante. Pulvinar ac turpis, ut amet mi gravida dapibus ante sit, architecto sem pellentesque, ipsum habitasse leo felis morbi purus nullam, enim dignissim. Lacus molestie erat eu nullam in pharetra, facilisis tincidunt neque.
      Augue felis malesuada penatibus erat ipsum, vestibulum eros posuere metus, egestas vitae eros per risus tellus.
    EOM
    result = Huffman.encode(text)
    expect(Huffman.decode(result[:encoded_text], result[:code_table])).to eql text
  end
end
