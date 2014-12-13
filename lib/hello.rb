# see http://qiita.com/yusabana/items/db44b81bdddf6ed0e9f5
# see http://qiita.com/jnchito/items/42193d066bd61c740612
class Hello
  def message
    "hello"
  end
end
class Person
  def initialize(name:, age:)
    @name = name
    @age = age
  end
  def greet
    if child?
      "ぼくは#{@name}だよ"
    else
      "僕は#{@name}です"
    end
  end
  def child?
    @age <= 12
  end
end

