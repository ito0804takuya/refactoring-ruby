class Movie
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price_code)
    @title = title # 映画のタイトル
    @price_code = price_code # 映画の料金コード
  end
end

class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie = movie # レンタルした映画
    @days_rented = days_rented # 貸出日数
  end

  # 料金
  def charge
    result = 0

    case rental.movie.price_code
    when Movie::REGULAR
      result += 2
      result += (rental.days_rented - 2) * 1.5 if rental.days_rented > 2
    when Movie::NEW_RELEASE
      result += rental.days_rented * 3
    when Movie::CHILDRENS
      result += 1.5
      result += (rental.days_rented - 3) * 1.5 if rental.days_rented > 3
    end
  end

  def frequent_renter_points
    # 新作の場合、2日間レンタルで2ポイント（ボーナス点）
    # それ以外（通常）は1ポイント
    element.movie.price_code == Movie::NEW_RELEASE && element.days_rented > 1 ? 2 : 1
  end
end

def Customer
  attr_reader :name

  def initialize(name)
    @name = name # 顧客の名前
    @rentals = [] # レンタルしている映画
  end

  def add_rental(arg)
    @rentals << arg
  end

  # 状態とは??
  def statement
    result = "Rental Record for #{@name}\n" # 出力する文字列

    @rentals.each do |element|
      # このレンタルの料金を表示
      result += "\t" + element.movie.title + "\t" + element.charge.to_s + "\n"
    end

    # フッター行を追加
    result += "Amount owed is #{total_charge}\n" # 合計金額
    result += "You earned #{total_frequent_renter_points} frequent renter points" # 加算されたレンタルポイント
    result
  end

  private

  # レンタル料金合計
  def total_charge
    @rentals.inject(0) { |sum, rental| sum += rental.charge }
  end

  def total_frequent_renter_points
    @rentals.inject(0) { |sum, rental| sum += rental.frequent_renter_points }
  end
end
