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