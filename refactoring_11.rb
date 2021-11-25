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