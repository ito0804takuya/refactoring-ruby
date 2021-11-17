class Item
  def initialize(base_price, tax_rate)
    @base_price = base_price
    @tax_rate = tax_rate
  end

  def raise_base_price_by(percent)
    @base_price = @base_price * (1 + percent/100)
  end

  def total
    @base_price * (1 + @tax_rate)
  end
end

# -------------------------------------------------

class Item
  attr_accessor :base_price, :tax_rate

  def initialize(base_price, tax_rate)
    @base_price = base_price
    @tax_rate = tax_rate
  end

  def raise_base_price_by(percent)
    base_price = base_price * (1 + percent/100)
  end

  def total
    base_price * (1 + tax_rate)
  end
end

class ImportedItem < Item
  attr_reader :import_duty

  def initialize(base_price, tax_rate, import_duty)
    super(base_price, tax_rate)
    # 関税
    @import_duty = import_duty
  end

  def tax_rate
    # Item側の振る舞いを変えず、簡単にtax_rateをオーバーライドできた
    super + import_duty
  end
end

# -------------------------------------------------
# -------------------------------------------------

class Order
  attr_accessor :customer

  def initialize(customer)
    @customer = customer # 顧客名(文字列)
  end
end

# ----------------------
# 別のクラスのどこかのコード
private

# 顧客が注文したorderの数を取得
def self.number_of_orders_for(orders, customer)
  orders.select { |order| order.customer == customer }.size
end

# -------------------------------------------------
class Order
  def initialize(customer)
    @customer = Customer.new(customer)
  end

  def customer
    @customer.name
  end

  def customer=(value)
    @customer = Customer.new(value)
  end
end

class Customer
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
# -------------------------------------------------
# -------------------------------------------------

new_network = { nodes: [], old_networks: [] }

new_network[:old_networks] << node.network
new_network[:nodes] << node

new_network[:name] = new_network[:old_networks].map { |network| network.name }.join(" - ")
# -------------------------------------------------
# このようにしたい↓
new_network = NewworkResult.new

new_network.old_networks << node.network
new_network.nodes << node

new_network.name = new_network.old_networks.map { |network| network.name }.join(" - ")

# なので、クラスを定義する↓
class NewworkResult
  attr_reader :old_networks, :nodes
  # attr_accessor :name ← メソッドに移した

  def initialize
    @old_networks, @nodes = [], []
  end

  # nameフィールド→nameメソッドに移し、処理を定義できる
  def name
    @old_networks.old_networks.map { |network| network.name }.join(" - ")
  end
end

# -------------------------------------------------
# -------------------------------------------------
def sample_method(number)
  number * 3.14
end
# -------------------------------------------------
PI = 3.14

def sample_method(number)
  number * PI
end

# -------------------------------------------------
# -------------------------------------------------

class Person
  # ..
end

class Female < Person
  def female?
    true
  end

  def code
    'F'
  end
end

class Male < Person
  def female?
    false
  end

  def code
    'M'
  end
end
# -------------------------------------------------
class Person
  def initialize(female, code)
    @female = female
    @code = code
  end

  def female?
    @female
  end

  def code
    @code
  end

  def self.create_female
    Person.new(true, 'F')
  end

  def self.create_male
    Person.new(false, 'M')
  end
end

# class Female < Person
#   def initialize
#     super(true, 'F')
#   end

  # def female?
  #   true
  # end

  # def code
  #   'F'
  # end
# end

# class Male < Person
#   def initialize
#     super(false, 'M')
#   end
  
  # def female?
  #   false
  # end

  # def code
  #   'M'
  # end
# end

# -------------------------------------------------
# -------------------------------------------------

class Sample
  def initialize
    @samples = []
  end
end
# -------------------------------------------------
class Sample
  def samples
    @samples ||= []
  end
end
# -------------------------------------------------
# -------------------------------------------------