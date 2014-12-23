class PagesController < ApplicationController
  COOKIE_FILE = "config/cookies.yml"

  # def index
  #   @donations = [Donation.last]
  # end

  def index

     unless File.read(COOKIE_FILE).length > 10
       @agent = connect_to_cp
     else
       @agent = Mechanize.new
       @agent.cookie_jar.load COOKIE_FILE
       @agent.get("https://sso.childsplaycharity.org/users/login/google")
       @agent.page.link_with(:text => "Organizer").click
       @agent.page.link_with(:text => "Donations").click
       @agent.get(ENV["CHILDS_PLAY_DONATION_PAGE"] + "/20")
     end


     table = @agent.page.at("table")
     @all_rows = table.css("tr")[2..-1]

     @all_rows.each do |row|
       data = row.css("td")

       unless Donation.find_by_timeadded(data[0].text.to_datetime)

        username = data[2].text
          
        username = "Anonymous" if username == "Unknown"

        @donation = Donation.new(:timeadded => data[0].text, 
                       :amount =>    data[1].text,
                       :username =>  username,
                       :comment =>   data[3].text )
        @donation.save
       end
     end

    if params[:after] != "undefined" && params[:after] != nil
      @donations = Donation.where("timeadded > ?", params[:after].to_datetime )
      @flag = "new items"
      unless @donations.size > 0
        @donations = [Donation.last]
        @flag = "last item"
      end
    else
      @donations = [Donation.last]
      @flag = "no items"
    end

   def connect_to_cp

     agent = Mechanize.new
     page = agent.get('https://sso.childsplaycharity.org/user/login')
     agent.page.link_with(:href => "https://sso.childsplaycharity.org/users/login/google").click
     form = agent.page.forms.last
     form.Email = ENV["GOOGLE_LOGIN"]
     form.Passwd = ENV["GOOGLE_PASSWORD"]
     form.submit

     agent.cookie_jar.save_as COOKIE_FILE
     agent.page.link_with(:text => "Organizer").click
     agent.page.link_with(:text => "Donations").click
     agent.get(ENV["CHILDS_PLAY_DONATION_PAGE"] + "/20")
     return agent
   end

  end
end
