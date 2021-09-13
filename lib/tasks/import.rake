namespace :import do
  desc "TODO"
  task movies: :environment do
    puts 'Importing...'
    require "csv"
    csv_movie = File.read(Rails.root.join("lib", "movies_csv", "movies.csv"))
    csv_review = File.read(Rails.root.join("lib", "movies_csv", "reviews.csv"))

    csv = CSV.parse(csv_movie, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      if Movie.where(movie: row.to_hash['Movie']).exists?
        movie = Movie.where(movie: row.to_hash['Movie']).first
        actore = movie.actore
        actore = actore | [row.to_hash['Actor']]
        movie.actore = actore
        movie.save!
      else
        m = Movie.new
        m.movie = row.to_hash['Movie']
        m.description = row.to_hash['Description']
        m.year = row.to_hash['Year']
        m.director = row.to_hash['Director']
        m.actore = [row.to_hash['Actor']]
        m.filming_location = row.to_hash['Filming location']
        m.country = row.to_hash['Country']
        m.save!
      end
    end

    csv = CSV.parse(csv_review, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      movie = Movie.where(movie: row.to_hash['Movie']).first
      r = Review.new
      r.movie = movie
      r.user = row.to_hash['User']
      r.stars = row.to_hash['Stars']
      r.review = row.to_hash['Review']
      r.save!

    end
  end


end
