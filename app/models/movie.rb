class Movie < ApplicationRecord
  has_many :reviews


  def self.search(search)
    if !search || search.empty?
      Movie.all.sort {|a,b| b.avg_score <=> a.avg_score}
    else
      Movie.where('actore @> ARRAY[?]::varchar[]', Array(search))
    end
  end

  def avg_score
    reviews.average(:stars).round(2).to_f
  end
end
