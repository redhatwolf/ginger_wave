class HomeController < ApplicationController
  before_filter :authenticate_user!  #添加这一句
  
  def index
    time1 =HomeController.new
    time = Time.now
    @time = time.strftime("Today is the %e#{time1.time_to_suffix} day of %B")
  end
  
  def time_to_suffix
    time = Time.now
    day = time.day
    if day==11 || day==12
      return "th"
    else
      case day % 10
      when 1 then return "st"
      when 2 then return "nd"
      when 3 then return "rd"
      else
        return "th"
      end
    end
  end

end
