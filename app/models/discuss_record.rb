class DiscussRecord < ApplicationRecord
  # text型カラムのdefault値設定のため
  attribute :detail, :text, default: ''

  # バリデーション
  validates :title, presence: true
  validates :detail, presence: true

  # アソシエーション
  belongs_to :pair
  has_many :personal_opinions, dependent: :destroy
  has_many :tag_relationships, dependent: :destroy
  # 投稿はN個のタグをもつ
  has_many :tags, through: :tag_relationships

  # レコードupdate後におしどりランクを判定
  after_update :judgement_rank

  # 使用未定 テスト用
  def self.seven_days_d_count(current_pair)
    # 何日の何時～何日の何時までか　『グラフ対象全体』の時間
    start_date = Date.current - 6 # 現在時刻から24時間×6日前
    # p start_date # デバッグ用
    end_date = Date.current #現在時刻
    # p end_date # デバッグ用
    dates = {} #データを格納するハッシュを用意
    # 7日間を1日ずつeach
    # この"date"は『もし時間に変換すると』あくまで0時0分0秒の一時点を示している
    (start_date..end_date).each do |date|
      p date # デバッグ用
      p date.to_datetime # デバッグ用
      # カウントの範囲指定(0時0分0秒～23時59分59秒)は別途する必要がある
      counts = current_pair.discuss_records.where(created_at: date.beginning_of_day...date.end_of_day).count
      dates.store(date.to_s, counts)
    end
    return dates
  end

  def self.this_year_d_count(current_pair)
    # 何日の何時～何日の何時までか　『グラフ対象全体』の時間
    date = Date.current.beginning_of_year # 現在の所属年の1月1日
    p date # デバッグ用
    dates = {} #データを格納するハッシュを用意
    for i in 1..12 do
      p i # デバッグ用
      # カウントの範囲指定(0時0分0秒～23時59分59秒)は別途する必要がある
      counts = current_pair.discuss_records.where(created_at: date.beginning_of_month.beginning_of_day..date.end_of_month.end_of_day).count
      dates.store("#{date.month}月", counts)
      date = date.next_month
      i = i + 1
    end
    return dates
  end

  def self.each_tags_count(current_pair)
    ratios = {}
    tags = current_pair.tags
    tags.each do |tag|
      counts = tag.discuss_records.count
      ratios.store("#{tag.name}",counts)
    end
    return ratios
  end

  def judgement_rank
    # このメソッドが呼び出される時点でモデルはpairの情報を持っている…から、『pair』を使える、らしい
    count = pair.discuss_records.where(is_closed: true).count

    # case文は比較演算子の場合には適していない模様
    # case count
    # when count >= 15
    #   pair.update(rank: "oshidori")
    # when count >= 8
    #   pair.update(rank: "kokko")
    # when count >= 3
    #   pair.update(rank: "hiyoko")
    # when count >= 0
    #   pair.update(rank: "tamago")
    # end

    if count >= 15
      pair.update(rank: "oshidori")
    elsif count >= 8
      pair.update(rank: "kokko")
    elsif count >= 3
      pair.update(rank: "hiyoko")
    else
      pair.update(rank: "tamago")
    end
  end

end
