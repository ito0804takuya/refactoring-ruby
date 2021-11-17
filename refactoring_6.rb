def printing_owing
  outstanding = 0.0

  # バナーを出力
  puts "*****************************"
  puts "****** Customer Owes ********"
  puts "*****************************"

  # 料金を計算
  @orders.each do |order|
    outstanding += order.amount
  end

  # 詳細を表示
  puts "name: #{@name}"
  puts "amount: #{outstanding}"
end

# -------------------------------------------------

def printing_owing
  outstanding = 0.0

  print_banner

  # 料金を計算
  @orders.each do |order|
    outstanding += order.amount
  end

  # 詳細を表示
  puts "name: #{@name}"
  puts "amount: #{outstanding}"
end

# バナーを出力
def print_banner
  puts "*****************************"
  puts "****** Customer Owes ********"
  puts "*****************************"
end

# -------------------------------------------------

def printing_owing
  outstanding = 0.0

  print_banner

  # 料金を計算
  @orders.each do |order|
    outstanding += order.amount
  end

  # <メソッドの抽出>
  print_details(outstanding)
end

# バナーを出力
def print_banner
  puts "*****************************"
  puts "****** Customer Owes ********"
  puts "*****************************"
end

# 詳細を表示
def print_details(outstanding)
  puts "name: #{@name}"
  puts "amount: #{outstanding}"
end

# -------------------------------------------------

def printing_owing
  print_banner

  # <メソッドの抽出>
  # ローカル変数に代入することで、以降のコードに影響を与えない
  outstanding = calculate_outstanding

  print_details(outstanding)
end

# バナーを出力
def print_banner
  puts "*****************************"
  puts "****** Customer Owes ********"
  puts "*****************************"
end

# 詳細を表示
def print_details(outstanding)
  puts "name: #{@name}"
  puts "amount: #{outstanding}"
end

# 料金を計算
def calculate_outstanding
  # outstanding = 0.0
  # @orders.each do |order|
  #   outstanding += order.amount
  # end
  # outstanding
  @order.inject(0.0) { |sum, order| sum + order.amount}
end

# -------------------------------------------------
# -------------------------------------------------

def get_rating
  more_than_five_late_deliveries ? 2 : 1
end

def more_than_five_late_deliveries
  @number > 5
end

# -------------------------------------------------

def get_rating
  @number > 5 ? 2 : 1
end

# -------------------------------------------------
# -------------------------------------------------

def price
  base_price = @quantity * @item_price
  if base_price > 1000
    discount_factor = 0.95
  else
    discount_factor = 0.98
  end
  base_price * discount_factor
end

# -------------------------------------------------

def price
  base_price * discount_factor
end

def base_price
  @quantity * @item_price
end

def discount_factor
  base_price > 1000 ? 0.95 : 0.98
end

# -------------------------------------------------

def price
  # base_priceが一時変数のままの場合
  base_price = @quantity * @item_price

  discount_factor(base_price)
  
  base_price * discount_factor
end

# base_priceはローカル変数なのでメソッドからアクセスできず、外部から渡さないといけない（引数など）
def discount_factor(base_price)
  base_price > 1000 ? 0.95 : 0.98
end

# -------------------------------------------------
# -------------------------------------------------

# class Select
#   def options
#     @options ||= []
#   end

#   def add_options(arg)
#     options << arg
#   end
# end

# selection = Select.new
# selection.add_options(2000)
# selection.add_options(2001)
# selection.add_options(2002)
# selection

# -------------------------------------------------

class Select
  # インスタンス初期化 + option追加 メソッドを追加 (newするのでクラスメソッド)
  def self.with_option(option)
    selection = self.new
    selection.options << option
    selection
  end

  def options
    @options ||= []
  end

  def add_option(arg)
    options << arg
    self # options(配列)でなく、self(インスタンス)を返す
  end
end

Select.with_option(2000).add_option(2001).add_option(2002)

# -------------------------------------------------
# -------------------------------------------------

def price
  # 基本価格 - 数量割引 + 配送料
  return @item_price * @quantity - 
    [0, @quantity - 500].max * @item_price * 0.05 +
    [@item_price * @quantity * 0.1, 100].min
end

# -------------------------------------------------

def price
  base_price = @item_price * @quantity
  quantity_discount = [0, @quantity - 500].max * @item_price * 0.05
  shipping = [base_price * 0.1, 100].min

  return base_price - quantity_discount + shipping
end

# -------------------------------------------------

def price
  return base_price - quantity_discount + shipping
end

def base_price
  @item_price * @quantity
end

def quantity_discount
  [0, @quantity - 500].max * @item_price * 0.05
end

def shipping
  [base_price * 0.1, 100].min
end

# -------------------------------------------------
# -------------------------------------------------

def discount(input_val)
  input_val -= 2 if input_val > 50
end
# -------------------------------------------------
def discount(input_val)
  result = input_val
  result -= 2 if input_val > 50
end

# -------------------------------------------------
# -------------------------------------------------

# class Account
#   # 大きなメソッド
#   def gamma(input_val, quantity, year_to_date)
#     important_value1 = (input_val * quantity) + delta
#     important_value2 = (input_val * year_to_date) + 100
    
#     if (year_to_date - important_value1) > 100
#       important_value2 -= 20
#     end

#     important_value3 = important_value2 * 7
#     # 色々な処理
#     important_value3 - 2 * important_value1
#   end
# end

# -------------------------------------------------

class Account
  # 大きなメソッド
  def gamma(input_val, quantity, year_to_date)
    Gamma.new(self, input_val, quantity, year_to_date).compute
  end
end

# メソッド→クラスに
class Gamma
  attr_reader :account, # 元のクラス
              # 引数
              :input_val, 
              :quantity, 
              :year_to_date,
              # 一時変数
              :important_value1, 
              :important_value2,
              :important_value3

  # 元のクラス + 元のメソッドの引数 を受け取る
  def initialize(account, input_val_arg, quantity_arg, year_to_date_arg)
    @account = account
    @input_val = input_val_arg
    @quantity = quantity_arg
    @year_to_date = year_to_date_arg
  end

  # 元のメソッドのロジック
  def compute
    @important_value1 = (input_val * quantity) + @account.delta
    @important_value2 = (input_val * year_to_date) + 100
    
    important_thing

    @important_value3 = important_value2 * 7
    # 色々な処理
    important_value3 - 2 * important_value1
  end

  # メソッドの抽出が簡単にできるようになった
  def important_thing
    if (year_to_date - important_value1) > 100
      @important_value2 -= 20
    end
  end
end

# -------------------------------------------------
# -------------------------------------------------

def fount_friends(people)
  friends = []
  people.each do |person|
    if(person == "Don")
      friends << "Don"
    end
    if(person == "John")
      friends << "John"
    end
    if(person == "Kent")
      friends << "Kent"
    end
  end
  return friends
end

# -------------------------------------------------

def fount_friends(people)
  people.select do |person|
    %w(Don John Kent).include?(person)
  end
end

# -------------------------------------------------
# -------------------------------------------------

# managers = []
# employees.each do |e|
#   managers << e if e.manager?
# end

# # 条件に合致するものだけを抽出する
# managers = employees.select { |e| e.manager? } # {}内は真偽値

# # -------------------------------------------------

# offices = []
# employees.each { |e| offices << e.office }

# # ブロックを実行した戻り値を格納する
# offices = employees.map { |e| e.office } # {}内は実行するブロック

# # -------------------------------------------------

# managerOffices = []
# employees.each do |e|
#   managerOffices << e.office if e.manager?
# end

# managerOffices = employees.select { |e| e.manager? }.map { |e| e.office }

# # -------------------------------------------------

# total = 0
# employees.each { |e| total += e.salary }

# total = employees.inject(0) { |sum, e| sum + e.salary }

# -------------------------------------------------
# -------------------------------------------------

class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death=nil, mother=nil)
    @name, @mother = name, mother
    @date_of_birth, @date_of_death = date_of_birth, date_of_death
    @children = []
    @mother.add_child(self) if @mother
  end

  def add_child(child)
    @children << child
  end

  def number_of_living_descendants # 子孫の数
    children.inject(0) do |count, child| 
      count += 1 if child.alive?
      count + child.number_of_living_descendants
    end
  end

  def number_of_descendants_named(name) # 名前が一致する数
    children.inject(0) do |count, child| 
      count += 1 if child.name == name
      count + child.number_of_descendants_named(name)
    end
  end

  def alive?
    @date_of_death.nil?
  end
end

# -------------------------------------------------

class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death=nil, mother=nil)
    @name, @mother = name, mother
    @date_of_birth, @date_of_death = date_of_birth, date_of_death
    @children = []
    @mother.add_child(self) if @mother
  end

  def add_child(child)
    @children << child
  end

  def alive?
    @date_of_death.nil?
  end

  def number_of_living_descendants # 子孫の数
    count_descendants_matching { |descendant| descendant.alive? }
  end

  def number_of_descendants_named(name) # 名前が一致する数
    count_descendants_matching { |descendant| descendant.name == name }
  end

  protected
  def count_descendants_matching(&block)
    children.inject(0) do |count, child|
      count += 1 if yield(child) # ブロックを実行。(ここは&blockを必要としない。)
      count + child.count_descendants_matching(&block)
      # ここ↑で再帰しており、再帰的にcount_descendants_matchingを実行したいので、
      # count_descendants_matchingには &block が必要。(再帰処理でなければ &block 不要。)
    end
  end
end

# -------------------------------------------------
# -------------------------------------------------

class Recorder
  instance_methods.each do |meth|
    undef_method meth unless meth =~ /^(__|inspect)/
  end

  def messages
    @messages ||= []
  end

  def method_missing(sym, *args)
    messages << [sym, args]
    self
  end

  def play_for(obj)
    messages.inject(obj) do |result, message|
      result.send message.first, *message.last
    end
  end

  # def to_s
  #   messages.inject([]) do |result, message|
  #     # ...
  #   end
  # end
end

class CommandCenter
  def start(command_string)
    p command_string
    # ...
    self
  end

  def stop(command_string)
    p command_string
    # ...
    self
  end
end

recorder = Recorder.new
recorder.start("LRMMMRL")
recorder.stop("LRMMMRL")
recorder.play_for(CommandCenter.new)

# -------------------------------------------------



# -------------------------------------------------
# -------------------------------------------------

# class Person
#   # attribute名の変数がまだ定義されてなければ、default_valueで定義する
#   def self.attr_with_default(options)
#     options.each_pair do | attribute, default_value |
#       define_method attribute do
#         eval "@#{attribute} ||= #{default_value}"
#       end
#     end
#   end

#   attr_with_default emails: "[]",
#                     employee_number: "EmployNumberGenerator.next"
# end

# # -------------------------------------------------

# class Person
#   # attribute名の変数がまだ定義されてなければ、default_valueで定義する
#   def self.attr_with_default(options)
#     options.each_pair do | attribute, default_value |
#       eval "define_method #{attribute} do
#               @#{attribute} ||= #{default_value}
#             end"
#     end
#   end

#   attr_with_default emails: "[]",
#                     employee_number: "EmployNumberGenerator.next"
# end

# # -------------------------------------------------
# # -------------------------------------------------
# 以下は、自作コード
# # -------------------------------------------------
# # -------------------------------------------------

def sample_method
  puts "sample_method"
  # その他諸々の処理...
end

# # -------------------------------------------------

def sample_method
  print_sample_method
end

def print_sample_method
  puts "sample_method"
  # その他諸々の処理...
end

# # -------------------------------------------------
# # -------------------------------------------------

def sample_method
  local_variable = 0
  puts "instance_variable: #{@instance_variable}"
  puts "local_variable: #{local_variable}"
  # その他諸々の処理で、local_variableは使われる...
end

# # -------------------------------------------------

def sample_method
  local_variable = 0
  print_sample_method(local_variable)
  # その他諸々の処理で、local_variableは使われる...
end

# ローカル変数は別メソッド間でアクセスできないため、引数で渡す必要がある。
def print_sample_method(local_variable)
  puts "instance_variable: #{@instance_variable}"
  puts "local_variable: #{local_variable}"
end

# # -------------------------------------------------
# # -------------------------------------------------

def sample_method
  local_variable = 0
  @sample.each do |sample|
    local_variable += sample.num
  end
  # その他諸々の処理で、local_variableは使われる...
end

# # -------------------------------------------------

def sample_method
  # ローカル変数に再代入することで、以降の処理に影響を与えない
  local_variable = calculate_sum
  # その他諸々の処理で、local_variableは使われる...
end

def calculate_sum
  # local_variable = 0
  # @sample.each do |sample|
  #   local_variable += sample.num
  # end
  # local_variable

  # 上記はinjectでスマートに書ける
  @sample.inject(0) { |local_variable, sample| local_variable + sample.num }
end

# -------------------------------------------------
# -------------------------------------------------
def sample_method
  is_more_than_five ? 2 : 1
end

def is_more_than_five
  @sample > 5
end
# -------------------------------------------------
def sample_method
  @sample > 5 ? 2 : 1
end
# -------------------------------------------------
# -------------------------------------------------
class Sample
  # 略

  def sample_method_equal_one
    if @count.present? && @count == 1
      @count += 1
    end
  end

  def sample_method_equal_arg(arg)
    if @count.present? && @count == arg
      @count += 1
    end
  end

  def sample_method_equal_one
    sample_method_logic { |count| count == 1 }
  end

  def sample_method_equal_arg(arg)
    sample_method_logic { |count| count == arg }
  end

  def sample_method_logic
    if @count.present? && yield(count)
      @count += 1
    end
  end
end
# -------------------------------------------------
