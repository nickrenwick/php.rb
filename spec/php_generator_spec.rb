require File.join(File.dirname(__FILE__), 'spec_helper')

describe PHP::Generator do
  context "literals" do
    it "should support null literals" do
      php('nil').to_s.should == 'NULL'
      php{ nil }.to_s.should == 'NULL'
    end

    it "should support boolean literals" do
      php('false').to_s.should == 'FALSE'
      php{ false }.to_s.should == 'FALSE'
      php('true').to_s.should  == 'TRUE'
      php{ true }.to_s.should  == 'TRUE'
    end

    it "should support integer literals" do
      php('42').to_s.should == '42'
      php{ 42 }.to_s.should == '42'
    end

    it "should support float literals" do
      php('3.1415').to_s.should == '3.1415'
      php{ 3.1415 }.to_s.should == '3.1415'
    end

    it "should support string literals" do
      php("''").to_s.should == '""'
      php{ '' }.to_s.should == '""'
      php('""').to_s.should == '""'
      php{ "" }.to_s.should == '""'
      php("'Hello, world!'").to_s.should == '"Hello, world!"'
      php{ 'Hello, world!' }.to_s.should == '"Hello, world!"'
    end
  end

  context "identifiers" do
    it "should support identifiers" do
      php(':foo').to_s.should == 'foo'
      php{ :foo }.to_s.should == 'foo'
    end
  end

  context "global variables" do
    it "should support global variables" do
      php('$foo').to_s.should == "$GLOBALS['foo']"
      php{ $foo }.to_s.should == "$GLOBALS['foo']"
    end

    it "should support global variable assignments" do
      php('$foo = 123').to_s.should == "$GLOBALS['foo'] = 123"
      php{ $foo = 123 }.to_s.should == "$GLOBALS['foo'] = 123"
    end
  end

  context "local variables" do
    it "should support local variables" do
      php('foo').to_s.should == '$foo'
      #php{ foo }.to_s.should == '$foo' # FIXME
    end

    it "should support local variable assignments"
  end

  context "anonymous functions" do
    it "should support functions of zero parameters" do
      php('lambda {}').to_s.should == 'function() {}'
      php{ lambda {} }.to_s.should == 'function() {}'
    end

    it "should support functions of one parameter" do
      php('lambda { |x| }').to_s.should == 'function($x) {}'
      php{ lambda { |x| } }.to_s.should == 'function($x) {}'
    end

    it "should support functions of many parameters" do
      php('lambda { |x, y| }').to_s.should == 'function($x, $y) {}'
      php{ lambda { |x, y| } }.to_s.should == 'function($x, $y) {}'
    end

    it "should support functions of variable arity"
  end

  context "named functions" do
    it "should support functions of zero parameters" do
      php('def foo; end').to_s.should == 'function foo() {}'
      php{ def foo; end }.to_s.should == 'function foo() {}'
      php('def foo(); end').to_s.should == 'function foo() {}'
      php{ def foo(); end }.to_s.should == 'function foo() {}'
    end

    it "should support functions of one parameter" do
      php('def foo(x); end').to_s.should == 'function foo($x) {}'
      php{ def foo(x); end }.to_s.should == 'function foo($x) {}'
    end

    it "should support functions of many parameters" do
      php('def foo(x, y); end').to_s.should == 'function foo($x, $y) {}'
      php{ def foo(x, y); end }.to_s.should == 'function foo($x, $y) {}'
    end

    it "should support functions of variable arity"
  end

  context "function calls" do
    it "should support function calls with zero arguments"

    it "should support function calls with one argument" do
      php('inc(1)').to_s.should == 'inc(1)'
      php{ inc(1) }.to_s.should == 'inc(1)'
    end

    it "should support function calls with many arguments" do
      php('add(1, 2)').to_s.should == 'add(1, 2)'
      php{ add(1, 2) }.to_s.should == 'add(1, 2)'
    end

    it "should support function calls with splat arguments"
  end

  context "interfaces" do
    it "should support interfaces" do
      php('module Foo; end').to_s.should == 'interface Foo {}'
      php{ module Foo; end }.to_s.should == 'interface Foo {}'
    end
  end

  context "classes" do
    it "should support classes without a parent class" do
      php('class Foo; end').to_s.should == 'class Foo {}'
      php{ class Foo; end }.to_s.should == 'class Foo {}'
    end

    it "should support classes with a parent class" do
      php('class Foo < Bar; end').to_s.should == 'class Foo extends Bar {}'
      php{ class Foo < Bar; end }.to_s.should == 'class Foo extends Bar {}'
    end
  end

  context "static method calls" do
    it "should support static method calls"
  end

  context "instance method calls" do
    it "should support instance method calls"
  end

  context "control structures" do
    it "should support return statements" do
      php('return').to_s.should == 'return'
      php{ return }.to_s.should == 'return'
      php('return nil').to_s.should == 'return NULL'
      php{ return nil }.to_s.should == 'return NULL'
      php('return true').to_s.should == 'return TRUE'
      php{ return true }.to_s.should == 'return TRUE'
      php('return 42').to_s.should == 'return 42'
      php{ return 42 }.to_s.should == 'return 42'
    end

    it "should support if statements" do # FIXME
      php('if true then 1 end').to_s.should == 'if (TRUE) { 1 }'
      php{ if true then 1 end }.to_s.should == 'if (TRUE) { 1 }'
    end

    it "should support if/else statements" do # FIXME
      php('if true then 1 else 0 end').to_s.should == 'if (TRUE) { 1 } else { 0 }'
      php{ if true then 1 else 0 end }.to_s.should == 'if (TRUE) { 1 } else { 0 }'
    end

    it "should support if/elseif statements"

    it "should support unless statements" do
      php('unless true  then 0 end').to_s.should == 'if (!TRUE) { 0 }'
      php{ unless true  then 0 end }.to_s.should == 'if (!TRUE) { 0 }'
      php('unless false then 1 end').to_s.should == 'if (!FALSE) { 1 }'
      php{ unless false then 1 end }.to_s.should == 'if (!FALSE) { 1 }'
    end

    it "should support unless/else statements" do # FIXME
      php('unless false then 1 else 0 end').to_s.should == 'if (FALSE) { 0 } else { 1 }'
      php{ unless false then 1 else 0 end }.to_s.should == 'if (FALSE) { 0 } else { 1 }'
    end

    it "should support while statements"
    it "should support do-while statements"
    it "should support for statements"
    it "should support foreach statements"
    it "should support break statements"
    it "should support continue statements"
    it "should support switch statements"
  end

  def php(input = nil, &block)
    if block_given?
      PHP::Generator.process(&block)
    else
      PHP::Generator.process(input)
    end
  end
end
