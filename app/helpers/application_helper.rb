module ApplicationHelper
  def rand_color
    ["teach-me", "", "handyman", "pick-up-delivery"].sample
  end

  def render_stars(comment)
    arr = []
    comment.rating.star_count.times do |star|
      arr << "#{fa_icon("star")}"
    end
    (5 - comment.rating.star_count).times do |star|
      arr << "#{fa_icon("star-o")}"
    end
    arr.join(" ").html_safe
  end

  def seach_icon
    fa_icon("search").html_safe
  end
end
