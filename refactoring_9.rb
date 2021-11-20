number = 11
if number >= 10 || number <= -10
  p "絶対値が10以上"
else
  p "絶対値が10未満"
end
# -------------------------------------------------
def is_over_ten(number)
  number >= 10 || number <= -10
end

number = 11

if is_over_ten(number)
  p "絶対値が10以上"
else
  p "絶対値が10未満"
end

# -------------------------------------------------
# -------------------------------------------------

samples = params.present? ? params : []
# -------------------------------------------------
samples = params : []

# -------------------------------------------------
def sample_method(number)
  if sample > 10
    1
  else
    2
  end
end
# -------------------------------------------------
def sample_method(number)
  return 1 if sample > 10
  2
end

# -------------------------------------------------
# -------------------------------------------------

def sample_method
  return 0 if @data.size > 5
  return 0 if @amount > 10
  1
end
# -------------------------------------------------
def sample_method
  return 0 if sample_condition
  1
end

def sample_condition
  @data.size > 5 || @amount > 10
end

# -------------------------------------------------
# -------------------------------------------------

def check_security(people)
  found = false # 制御フラグ
  people.each do |person|
    unless found
      if person == "Taro"
        send_alert
        found = true # ある条件に合致したら制御フラグを切り替え
      end
      if person == "Hanako"
        send_alert
        found = true
      end
    end
  end
end
# -------------------------------------------------
def check_security(people)
  people.each do |person|
    if person == "Taro"
      send_alert
      break # ループを抜ける
    end
    if person == "Hanako"
      send_alert
      break
    end
  end
end

# -------------------------------------------------

def check_security(people)
  # 制御フラグ かつ 別で使用する値
  found = "" # 初期値
  people.each do |person|
    if found == ""
      if person == "Taro"
        send_alert
        found = "Taro"
      end
      if person == "Hanako"
        send_alert
        found = "Hanako"
      end
    end
  end
  some_later_code(found)
end
# -------------------------------------------------
def check_security(people)
  found = found_miscreant(people) # 2つのことをしていたので、メソッドに切り出し
  some_later_code(found)
end

# foundの値を返すメソッド
def found_miscreant(people)
  people.each do |person|
    if person == "Taro"
      send_alert
      return "Taro" # 早期return
    end
    if person == "Hanako"
      send_alert
      return "Hanako"
    end
    end
  end
  "" # 条件に合致しなかった → 初期値のまま
end

# -------------------------------------------------
# -------------------------------------------------

# 支払う給与
def pay_amount
  if @dead
    result = dead_amount # 死亡
  else
    if @separated
      result = separated_amount # 別居中
    else
      if @retired
        result = retired_amount # 退職
      else
        result = normal_pay_amount # 通常
      end
    end
  end
  result
end
# -------------------------------------------------
# 支払う給与
def pay_amount
  return dead_amount if @dead # 死亡 
  return separated_amount if @separated # 別居中
  return retired_amount if @retired # 退職
  normal_pay_amount # 通常
end

# -------------------------------------------------

def adjussted_capital
  result = 0
  if @capital > 0
    if @interest_rate > 0 && @duration > 0
      result = ( @income / @duration) * ADJ_FACTOR
    end
  end
  result
end
# -------------------------------------------------
def adjussted_capital
  return 0 if @capital <= 0
  return 0 if @interest_rate <= 0 || @duration <= 0
  (@income / @duration) * ADJ_FACTOR
end