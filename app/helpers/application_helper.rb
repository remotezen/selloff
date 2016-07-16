module ApplicationHelper
  def complete_title(title ="")
    this_title = "Sell Off Auction"
    if title.empty?
      this_title
    else
      title  + " | "  + this_title
    end
  end

  def form_error_for(object=nil)
    render('shared/form_errors', object: object) unless object.blank?
  end
  def maximum(obj)
    obj.maximum_bid
  end
  def minimum(obj)
    obj.minimum_bid
  end

  def date_to_hash(date)
    clock = date.to_s.split( " " )
    d_arr = clock[0].split('-')
    hour_arr = clock[1].split(':')
    corrected_month = d_arr[1].to_i - 1
    date_hash =  {year: d_arr[0],
                  month: corrected_month,
                  day: d_arr[2],
                  hour: hour_arr[0],
                  minute: hour_arr[1],
                  second: hour_arr[2]
    }
    return date_hash
  end


  def set_countdown(t, increase)
    razor = 24 * 60 * 60
    incr = razor * increase
    sub = t.to_i + incr

    diff  = Time.zone.at(sub)
    return diff


  end



  def time_math(date)
    hash = date_to_hash(date)
    year = hash[:year].to_i
    month = hash[:month].to_i
    day = hash[:day].to_i
    hour = hash[:hour].to_i
    min = hash[:minute].to_i
    sec = hash[:second].to_i
    t0 = Time.zone.local(year, month, day, hour, min,sec)
    t1 = Time.zone.now
    diff = t1.to_i - t0.to_i
    return diff
  end


  def time_hash(time)
    day = (24 * 3600)
    hour = 3600
    min = 60
    total_secs = time_math(time)
    t_days = total_secs / day
    hours = total_secs % day
    t_hours = hours / hour
    mins = hours % hour
    t_mins = mins / min
    h = {days: t_days,
        hours: t_hours,
        minutes: t_mins
    }
    return h
  end


  def timestamp(time)
    Time.zone.at(time)

  end



end

