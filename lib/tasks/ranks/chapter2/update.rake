namespace :ranks do
  namespace :chapter2 do
    desc 'chapter2 ゲーム内のユーザーランキング情報を更新する'
    task update: :environment do
      # 現在のランキング情報をリセット

      # ユーザーごとにスコアの合計を計算する

      # ユーザーごとのスコア合計の降順に並べ替え、そこからランキング情報を再作成する
    end
  end
end
