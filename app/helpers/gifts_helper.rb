module GiftsHelper
  
  def height
    if Gift.percentage_collected > 99
      height = 300
    else
      height = (((Gift.grand_total_in_cents * 100) / Gift.goal_in_cents) * 300) / 100
    end
    height
  end
  
  def margin_top
    if Gift.percentage_collected > 99
      margin_top = 0
    else
      margin_top = 300 - height.to_i
    end
    margin_top
  end
  
end
