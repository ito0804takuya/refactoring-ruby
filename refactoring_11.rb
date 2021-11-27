class JobItem
  attr_reader :quantity, :employee

  def initialize(unit_price, quantity, is_labor, employee)
    @unit_price = unit_price
    @quantity = quantity
    @is_labor = is_labor
    @employee = employee
  end

  def total_price
    unit_price * @quantity
  end

  def unit_price
    # labor(修理するのが大変)かどうかで振る舞いが変わる
    labor? ? @employee.rate : @unit_price
  end

  def labor?
    @is_labor
  end
end
# -------------------------------------------------
class JobItem
  attr_reader :unit_price, :quantity

  # employeeは不要になった
  def initialize(unit_price, quantity, is_labor=false)
    @unit_price = unit_price
    @quantity = quantity
    @is_labor = is_labor
  end

  def total_price
    unit_price * @quantity
  end

  def labor?
    false
  end
end

# 子クラス
class LaborItem < JobItem
  attr_reader :employee

  # LaborItemの生成には、unit_price, is_laborは不要
  def initialize(quantity, employee)
    super(0, quantity, true) # is_laborはtrue
    @employee = employee
  end

  def labor?
    true
  end

  def unit_price
    @employee.rate
  end
end

# -------------------------------------------------
# -------------------------------------------------

class MountaionBike
  TIRE_WIDTH_FACTOR = 6
  attr_accessor :tire_diameter

  def wheel_circumference
    Math::PI * (@wheel_diameter + @tire_diameter)
  end

  def off_road_ability
    @tire_diameter * TIRE_WIDTH_FACTOR
  end
end

class FrontSuspensionMountainBike
  TIRE_WIDTH_FACTOR = 6
  FRONT_SUSPENTION_FACTOR = 8
  attr_accessor :tire_diameter, :front_fork_travel

  def wheel_circumference
    # MountaionBikeと同じ
    Math::PI * (@wheel_diameter + @tire_diameter)
  end

  def off_road_ability
    # MountaionBikeと少し違う
    @tire_diameter * TIRE_WIDTH_FACTOR + @front_fork_travel * FRONT_SUSPENTION_FACTOR
  end
end
# -------------------------------------------------
class MountaionBike
  TIRE_WIDTH_FACTOR = 6
  attr_accessor :tire_diameter

  def wheel_circumference
    Math::PI * (@wheel_diameter + @tire_diameter)
  end

  def off_road_ability
    @tire_diameter * TIRE_WIDTH_FACTOR
  end
end

# MountaionBikeの派生なので、MountaionBikeの子クラスにする
class FrontSuspensionMountainBike < MountaionBike
  FRONT_SUSPENTION_FACTOR = 8
  attr_accessor :front_fork_travel

  def off_road_ability
    # MountaionBikeの結果から、FrontSuspensionMountainBike独自の計算をする
    super + @front_fork_travel * FRONT_SUSPENTION_FACTOR
  end
end

# -------------------------------------------------
# -------------------------------------------------
# 11.8
# レシート表示
def statement
  result = "レンタル #{name}"
  @rentals.each do |rental|
    result << "#{rental.movie.title} #{rental.charge}" # 映画のタイトル、料金
  end
  result << "合計#{total_charge}"
  result << "#{total_frequent_rental_points}"
  result
end

# レシートをHTMLで表示（なのでstatementと少し違う）
def html_statement
  result = "<h1>レンタル #{name}</h1>"
  @rentals.each do |rental|
    result << "#{rental.movie.title} #{rental.charge}<br/>"
  end
  result << "<p>合計#{total_charge}</p>"
  result << "<p>#{total_frequent_rental_points}</p>"
  result
end

# -------------------------------------------------

# クライアントコード``````
class Customer
  def statement
    TextStatement.value(self)
  end

  def html_statement
    HtmlStatement.value(self)
  end
end
# ````````

class Statement
  # 2つの子クラスで共通している処理
  def value(customer)
    result = header_string(customer)
    customer.rentals.each do |rental|
      result << each_rental_string(rental)
    end
    result << footer_string(customer)
  end
end

# 子クラス側では、独自の実装をする
class TextStatement < Statement
  def header_string(customer)
    "レンタル #{customer.name}"
  end

  def each_rental_string(rental)
    "#{rental.movie.title} #{rental.charge}"
  end

  def footer_string(customer)
    <<-EOS
      "合計#{customer.total_charge}"
      result << "#{customer.total_frequent_rental_points}"
    EOS
  end
end

class HtmlStatement < Statement
  def header_string(customer)
    "<h1>レンタル #{customer.name}</h1>"
  end

  def each_rental_string(rental)
    "#{rental.movie.title} #{rental.charge}<br/>"
  end

  def footer_string(customer)
    <<-EOS
      "<p>合計#{customer.total_charge}</p>"
      "<p>#{customer.total_frequent_rental_points}</p>"
    EOS
  end
end
# -------------------------------------------------
# -------------------------------------------------
# クライアントコード``````
class Customer
  def statement
    Statement.new.extend(TextStatement).value(self)
  end

  def html_statement
    Statement.new.extend(HtmlStatement).value(self)
  end
end
# ````````

class Statement
  # ...
end

module TextStatement
  # ...
end

module HtmlStatement
  # ...
end

# -------------------------------------------------
# -------------------------------------------------
# 11.9

# Hashを継承
# 個々のPolicy(Hash)要素は、RulesのArray
class Policy < Hash
  attr_reader :name

  def initialize(name)
    @name = name
  end

  # Array風のインターフェイスを作っている
  def <<(rule)
    key = rule.attribute
    self[key] ||= []
    self[key] << rule
  end

  def apply(account)
    self.each do |attribute, rules|
      rules.each { |rule| rule.apply(account)}
    end
  end
end

class Rule
  attr_reader :attribute, :default_value

  def initialize(attribute, default_value)
    @attribute, @default_value = attribute, default_value
  end

  def apply(account)
    p account
  end
end
# -------------------------------------------------
# Hashを継承
# 個々のPolicy(Hash)要素は、RulesのArray
class Policy
  attr_reader :name

  def initialize(name)
    @name = name
    @rules = {}
  end

  # Array風のインターフェイスを作っている
  def <<(rule)
    key = rule.attribute
    @rules[key] ||= []
    @rules[key] << rule
  end

  def apply(account)
    @rules.each do |attribute, rules|
      rules.each { |rule| rule.apply(account)}
    end
  end
end

class Rule
  attr_reader :attribute, :default_value

  def initialize(attribute, default_value)
    @attribute, @default_value = attribute, default_value
  end

  def apply(account)
    p account
  end
end