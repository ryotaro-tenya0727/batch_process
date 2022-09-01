class User < ApplicationRecord
  has_many :user_scores
  has_one :rank

  def total_score
    # からの配列に.sum(&:score)を実行する
    @total_score ||= user_scores.sum(&:score)
  end
end
