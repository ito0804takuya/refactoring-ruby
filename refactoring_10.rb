def sample_method
  "#{name_last} #{name_first}"
end
# -------------------------------------------------
def sample_method
  full_name
end

def full_name
  "#{name_last} #{name_first}"
end

# -------------------------------------------------
# -------------------------------------------------

def found_miscreant(people)
  people.each do |person|
    if person == "Don"
      send_alert
      return "Don"
    end
    if person == "John"
      send_alert
      return "John"
    end
  end
  ""
end

def check_security(people)
  found = found_miscreant(people)
  some_later_code(found)
end
# -------------------------------------------------
def found_miscreant(people)
  people.each do |person|
    if person == "Don"
      send_alert
      return
    end
    if person == "John"
      send_alert
      return
    end
  end
  nil
end

def check_security(people)
  # 状態を更新する
  found_miscreant(people)
  # 問い合わせ
  found = found_person(people)
  some_later_code(found)
end

def found_person(people)
  people.each do |person|
    return "Don" if person == "Don"
    return "John" if person == "John"
  end
  ""
end
# -------------------------------------------------
# -------------------------------------------------

class Account
  def add_charge(base_price, tax_rate, imported)
    total = base_price + base_price * tax_rate
    total += base_price * 0.1 if imported
    @charges << total
  end

  def total_charge
    @charges.inject { |total, charge| total + charge }
  end
end

# クライアント（利用側）
account.add_charge(5, 0.1, true)
account.add_charge(12, 0.125, false)

total = account.total_charge
# -------------------------------------------------
# 自然にまとめられる引数のグループを、オブジェクトにする
class Charge
  attr_accessor :base_price, :tax_rate, :imported

  def initialize(base_price, tax_rate, imported)
    @base_price = base_price
    @tax_rate = tax_rate
    @imported = imported
  end
end

class Account
  def add_charge(charge)
    total = charge.base_price + charge.base_price * charge.tax_rate
    total += charge.base_price * 0.1 if charge.imported
    @charges << total
  end

  def total_charge
    @charges.inject { |total, charge| total + charge }
  end
end

# クライアント（利用側）
account.add_charge(Charge.new(5, 0.1, true))
account.add_charge(Charge.new(12, 0.125, false))

total = account.total_charge
# -------------------------------------------------
# -------------------------------------------------

class ProductController
  def create
    @product = if imported
                  ImportedProduct.new(base_price)
                else
                  if base_price > 1000
                    LuxuryProduct.new(base_price)
                  else
                    Product.new(base_price)
                  end
                end
  end
end

class Product
  def initialize(base_price)
    @base_price = base_price
  end

  def total_price
    @base_price
  end
end

class LuxuryProduct < Product
  def total_price
    super + 0.1 * super
  end
end

class ImportedProduct < Product
  def total_price
    super + 0.25 * super
  end
end
# -------------------------------------------------
class ProductController
  def create
    @product = Product.create(base_price, imported)
  end
end

class Product
  def initialize(base_price)
    @base_price = base_price
  end

  def self.create(base_price, imported=false)
    if imported
      ImportedProduct.new(base_price)
    else
      if base_price > 1000
        LuxuryProduct.new(base_price)
      else
        Product.new(base_price)
      end
    end
  end

  def total_price
    @base_price
  end
end

class LuxuryProduct < Product
  def total_price
    super + 0.1 * super
  end
end

class ImportedProduct < Product
  def total_price
    super + 0.25 * super
  end
end

# -------------------------------------------------
# -------------------------------------------------

class Account
  # 引き出し
  def withdraw(amount)
    @balance = 10
    return -1 if amount > @balance # エラーコード（-1とは？）
    @balance -= amount
    return 0
  end
end
# -------------------------------------------------

account = Account.new
amount = 11
if account.withdraw(amount) == -1
  handle_overdrawn # エラーの場合に実行
else
  do_the_usual_thing # 通常実行される処理
end
# -------------------------------------------------
require "rspec/expectations"

include RSpec::Matchers

class Account
  # 引き出し
  def withdraw(amount)
    @balance = 10
    expect(amount).to be <= @balance
    @balance -= amount
  end
end

account = Account.new
amount = 11

if !account.withdraw(amount)
  handle_overdrawn
else
  account.withdraw(amount)
end

# -------------------------------------------------
# -------------------------------------------------

