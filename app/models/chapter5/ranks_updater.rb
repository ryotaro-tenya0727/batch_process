module Chapter5
  class RanksUpdater
    def update_all
      # 現在のランキング情報をリセット
      Rank.transaction do
        Rank.delete_all
        # ユーザーごとのスコア合計を降順に並べ替え、そこからランキング情報を再作成する
        Development::UsedMemoryReport.instance.write('after Rank.delete_all')
        create_ranks
      end
    end

    private

    # def create_ranks
    #   # ユーザーごとにスコアの合計を計算する
    #   user_total_scores = User.all.map do |user|
    #     { user_id: user.id, total_score: user.user_scores.sum(&:score) }
    #   end

    #   # ユーザーごとのスコア合計の降順に並べ替え、そこからランキング情報を再作成する
    #   sorted_total_score_groups = user_total_scores
    #                           .group_by { |score| score[:total_score] }
    #                           .sort_by { |score, _| score * -1 }
    #                           .to_h
    #                           .values

    #   sorted_total_score_groups.each.with_index(1) do |scores, index|
    #     scores.each do |total_score|
    #       Rank.create(user_id: total_score[:user_id], rank: index, score: total_score[:total_score])
    #     end
    #   end
    # end
    def create_ranks
      ranks = []
      RankOrderMaker.new.each_ranked_user do |user, rank|
        ranks << Rank.new(user_id: user.id, rank: rank, score: user.total_score)
      end
      Development::UsedMemoryReport.instance.write('after RankOrderMaker.new.each_ranked_user')

      Rank.import ranks

      Development::UsedMemoryReport.instance.write('after Rank.import')
    end
  end
end
