
# 口座
class Account
  def overdraft_charge
    if @account_type.premium?
      result = 10
      resut += (@day_overdrawn -7) * 0.85 if @day_overdrawn > 7
      result
    else
      @day_overdrawn * 1.75
    end
  end

  def bank_charge
    result = 4.5
    result += overdraft_charge if @day_overdrawn > 0
    result
  end
end

# 口座の種類
def AccountType
  # ...
end

# -------------------------------------------------

# 口座
class Account
  def overdraft_charge
    @account_type.overdraft_charge(@day_overdrawn)
  end

  def bank_charge
    result = 4.5
    result += overdraft_charge if @day_overdrawn > 0
    result
  end
end

# 口座の種類
def AccountType
  # ...
  def overdraft_charge(day_overdrawn)
    if premium?
      result = 10
      resut += (day_overdrawn -7) * 0.85 if day_overdrawn > 7
      result
    else
      day_overdrawn * 1.75
    end
  end
end

# -------------------------------------------------

# 口座
class Account
  # ...
  def bank_charge
    result = 4.5
    result += @account_type.overdraft_charge(@day_overdrawn) if @day_overdrawn > 0
    result
  end
end

# 口座の種類
def AccountType
  # ...
  def overdraft_charge(day_overdrawn)
    if premium?
      result = 10
      resut += (day_overdrawn -7) * 0.85 if day_overdrawn > 7
      result
    else
      day_overdrawn * 1.75
    end
  end
end

# -------------------------------------------------
# -------------------------------------------------

# 口座
class Account
  # ...
  def interest_for_amount_days(amount, days)
    @interest_rate * amount * days /365
  end
end

# -------------------------------------------------

# 口座
class Account
  # ...
  def interest_for_amount_days(amount, days)
    interest_rate * amount * days /365
  end

  def interest_rate
    @account_type.interest_rate
  end
end

# -------------------------------------------------
# -------------------------------------------------

# class Person
#   attr_reader :name
#   attr_accessor :office_area_code
#   attr_accessor :office_number
  
#   def telephone_number
#     '(' + @office_area_code + ')' + @office_number
#   end
# end

# -------------------------------------------------

class Person
  attr_reader :name

  # 新しいクラスへのリンクを作る
  def initialize
    @office_telephone = TelephoneNumber.new
  end

  # 既存のフィールドは、新しいクラスのフィールドに向ける
  # ゲッター
  # def office_area_code
  #   @office_telephone.area_code
  # end
  # # セッター
  # def office_area_code(arg)
  #   @office_telephone.area_code = arg
  # end

  def office_telephone
    @office_telephone
  end

  # メソッドは新しいクラスに移動
  def telephone_number
    @office_telephone.telephone_number
  end
end

class TelephoneNumber
  attr_accessor :area_code, :number

  def telephone_number
    '(' + area_code + ')' + number
  end
end

person = Person.new
# person.office_area_code = 123
# p person.office_area_code
person.office_telephone.area_code = 123
p person.office_telephone.area_code

# -------------------------------------------------
# -------------------------------------------------

class Person
  attr_reader :name

  def initialize
    @office_telephone = TelephoneNumber.new
  end

  def office_telephone
    @office_telephone
  end

  def telephone_number
    @office_telephone.telephone_number
  end
end

class TelephoneNumber
  attr_accessor :area_code, :number

  def telephone_number
    '(' + area_code + ')' + number
  end
end

# -------------------------------------------------

class Person
  attr_reader :name

  def initialize
    @office_telephone = TelephoneNumber.new
  end

  def office_telephone
    @office_telephone
  end

  # メソッドは新しいクラスに移動
  def telephone_number
    @office_telephone.telephone_number
  end
end

class TelephoneNumber
  attr_accessor :area_code, :number

  def telephone_number
    '(' + area_code + ')' + number
  end
end

# -------------------------------------------------
# -------------------------------------------------

# 社員
class Person
  attr_accessor :department
end

# 部門
class Department
  attr_reader :manager

  def initialize(manager)
    @manager = manager
  end
end

manager = person.department.manager

# -------------------------------------------------

class Person
  attr_writer :department # ゲッターは不要になった

  def manager
    @department.manager
  end
end

class Department
  attr_reader :manager

  def initialize(manager)
    @manager = manager
  end

  # ...
end

# managerを取得するためにはdepartmentを経由しないといけない という知識が必要なくなる
manager = person.manager