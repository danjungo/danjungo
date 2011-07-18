require "hpricot"

# Hpricot Text GSub 0.1.4
# Copyright Christoffer Sawicki 2006
# Licensed under the same terms as Ruby

# Contributors:
#  * Tim Fletcher
#
# Cheers!

# Please send bug reports and improvements to
# christoffer.sawicki@gmail.com

# See the test cases at the bottom for usage

module HpricotTextGSub
  module NodeWithChildrenExtension
    def text_gsub!(*args, &block)
      children.each { |x| x.text_gsub!(*args, &block) }
    end
  end
  
  module TextNodeExtension
    def text_gsub!(*args, &block)
      content.gsub!(*args, &block)
    end
  end
end

Hpricot::Doc.send(:include,  HpricotTextGSub::NodeWithChildrenExtension)
Hpricot::Elem.send(:include, HpricotTextGSub::NodeWithChildrenExtension)
Hpricot::Text.send(:include, HpricotTextGSub::TextNodeExtension)

if __FILE__ == $0
  require "test/unit"
  
  class HpricotTextGSubTest < Test::Unit::TestCase
    def assert_hpricot_gsub(expected, input, *args, &block)
      doc = Hpricot(input)
      doc.text_gsub!(*args, &block)
      
      assert_equal(expected, doc.to_s)
    end
    
    def test_with_root
      input    = '<a href="xxx">xxx</a>'
      expected = '<a href="xxx">yyy</a>'
      
      assert_hpricot_gsub(expected, input, 'xxx', 'yyy')
    end
    
    def test_without_root
      input    = '<a href="xxx">xxx</a><a href="xxx">xxx</a>'
      expected = '<a href="xxx">yyy</a><a href="xxx">yyy</a>'

      assert_hpricot_gsub(expected, input, 'xxx', 'yyy')   
    end
    
    def test_replacement_insertion
      input    = '<a href="xxx">xxx</a>'
      expected = '<a href="xxx">*xxx*</a>'

      assert_hpricot_gsub(expected, input, /(xxx)/, '*\1*')
    end
    
    def test_block
      input    = '<a href="xxx">xxx</a>'
      expected = '<a href="xxx">xxxzzz</a>'

      assert_hpricot_gsub(expected, input, 'xxx') { |x| x + "zzz" }  
    end
    
    # This would optimally work, but it doesn't because of scoping
    def test_failure_of_normal_block_insertion_1
      input = '<a href="xxx">xxx</a>'

      Hpricot(input).text_gsub!(/(xxx)/) { assert_nil($1) }
    end

    # Regexp.last_match doesn't work either :(    
    def test_failure_of_normal_block_insertion_2
      input = '<a href="xxx">xxx</a>'

      Hpricot(input).text_gsub!(/(xxx)/) { assert_nil(Regexp.last_match) }
    end
  end
end
