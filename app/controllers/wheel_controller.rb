class WheelController < ApplicationController

  def hsv_to_rgb(h, s, v)
    h_i = (h*6).to_i
    f = h*6 - h_i
    p = v * (1 - s)
    q = v * (1 - f*s)
    t = v * (1 - (1 - f) * s)
    r, g, b = v, t, p if h_i==0
    r, g, b = q, v, p if h_i==1
    r, g, b = p, v, t if h_i==2
    r, g, b = p, q, v if h_i==3
    r, g, b = t, p, v if h_i==4
    r, g, b = v, p, q if h_i==5
    [(r*256).to_i, (g*256).to_i, (b*256).to_i]
  end


  def index

    @params = "#" + params[:channel_name]

    @bot = Cinch::Bot.new {
    # bot.loggers.level = :fatal
      configure { |c|
        c.nick = ENV["TWITCH_USERNAME"]
        c.password = ENV["TWITCH_OAUTH_PASSWORD"]
        c.server = 'irc.twitch.tv'
        c.port = 6667
      }
    }

    @bot.instance_exec(@params) do |params|
      configure { |c|
        c.channels = [params]
      }
    end

    @thr ||= Thread.new { @bot.start }

    @users = []

    # loop do
    #   if @bot.channel_list.first && @bot.channel_list.first.users.count > 2
    #     logger.info "THE COUNT IS #{@bot.channel_list.first.users.count}"
    #     break
    #   end
    # end
      

      @channel = @bot.channel_list.first

      @channel.users.each { |user|
        @users << user.first.nick
      }

    @bot.quit

    @thr.kill


    # if @users.count < 1
    #   sleep(20)
    #   @channel = @bot.channel_list.first

    #   @channel.users.each { |user|
    #     @users << user.first.nick
    #   }
    # end

    @users.delete(params[:channel_name])
    @users.delete(ENV["TWITCH_USERNAME"])
    @users.delete('antdiddly')
    @users.delete('gr_david_r')
    @users.delete('gr_jann')
    @users.delete('antdiddly')



    if @users.count > 25
      @users = @users.sample(25)
    end


    @rgbcolors = []
    @hexcolors = []

    @users.count.times {
      @rgbcolors<< hsv_to_rgb(0.10, (rand(20..70)/100.0), 0.90)
    }

    @rgbcolors.each do |color|
      @color_as_hex = "#"
      color.each do |component|
        hex = component.to_s(16)
        if component < 16
          @color_as_hex << "0#{hex}"
        else
          @color_as_hex << hex
        end
      end
      @hexcolors << @color_as_hex
    end

  end

end
