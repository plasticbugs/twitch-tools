# Twitch Tools #
This is a small but growing set of on-screen, chromakey-able widgets for Twitch streamers. These widgets are on pure green backgrounds so they can be easily cropped and keyed out with your streaming software package.

### Childs Play Charity Donation Widget ##
A donation widget that scrapes ChildsPlayCharity.org and posts donations on screen as they occur along with the donor's username, message and amount. Donation messages stay on-screen for 30 seconds, then fade away.

The donation widget sanitizes foul language in donation usernames and messages by default. You can disable this by removing the "Obscenity#sanitize" method surrounding the interpolated message string in apps/views/pages/_donations.html.erb partial (lines 4, 5, & 11).

The donation widget needs your Google login info in order to log in and scrape the Childsplay website with help from Mechanize.

## Carnival-style Prize Wheel ##

![Image of Yaktocat](https://github.com/plasticbugs/twitch-tools/tree/master/app/assets/images/wheel_example.png)

A prize wheel that contains a maximum of 25 randomly selected viewers of a given Twitch.tv channel -- the names are pulled from the chat room. The user can click the Spin button for each prize to be awarded to lucky viewers.

When the wheel stops spinning, the winning viewer is presented in the middle of the wheel.

Currently, the app ignores the user that matches the TWITCH_USERNAME ENV variable and the selected channel's username. More can be added to the ignore list. See lines 72 & 73 of app/controllers/wheel_controller.rb.

### URLS: ##
The donation widget currently lives at:

`
rooturl/pages
`

The prize wheel endpoint is:

```
rooturl/wheel/[twitch channel name]
rooturl/wheel/gamesdonequick //for example
```

### ENV Variables ###
create a .env in this app's root directory with these variables

```
TWITCH_USERNAME="your_twitch_username"
TWITCH_OAUTH_PASSWORD="twitch_oauth_password"
CHILDS_PLAY_DONATION_PAGE="https://donate.childsplaycharity.org/your_url_here"
GOOGLE_LOGIN="your_google_login_for_childsplay"
GOOGLE_PASSWORD="your_google_password_for_childsplay_authentication"
```
To get a Twitch username, sign up for an account at http://www.twitch.tv

Get your Twitch oauth password via this page: http://twitchapps.com/tmi/

**For Childsplay:**
* Make sure you've created your Childs Play account using your Google login info. Currently, this widget only supports Google logins for Childs Play.
* To get the URL needed for the DONATION_PAGE variable, [sign in with your Google account here](https://sso.childsplaycharity.org/user/login).
* Now, click the "Organizer" link in the navigation bar.
* Finally, click the "Donations" link next to your event's name and copy that page's URL and paste it into the appropriate variable in your .env file.