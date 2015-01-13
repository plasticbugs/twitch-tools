# Twitch Tools #

This is a small but growing set of on-screen, chromakey-able widgets for Twitch streamers.

Currently Implemented:

### Childs Play Charity Donation Widget ##
A donation widget that scrapes ChildsPlayCharity.org and posts donations on screen as they occur along with the donor's username, message and amount. Donation messages stay on-screen for 30 seconds, then fade away. The donations widget sanitizes foul language in donation messages by default. You can disable this by removing the "Obscenity#sanitize" method surrounding the interpolated message string in the _donations.html.erb partial (lines 4, 5, & 11).

## Carnival-style Prize Wheel ##
A prize wheel that pulls in a maximum of 25 randomly selected users from a given Twitch.TV chat room. The user can click the Spin button for each prize to be awarded to lucky viewers.

### URLS: ##
The donation widget currently lives at:

`
rooturl/pages
`

The prize wheel endpoint is:

`
rooturl/wheel/[twitch channel name]

rooturl/wheel/gamesdonequick //for example
`

### ENV Variables ###
create a .env in this app's root directory with these variables

```
TWITCH_USERNAME="your_twitch_username"
TWITCH_OAUTH_PASSWORD="twitch_oauth_password"
CHILDS_PLAY_DONATION_PAGE="https://donate.childsplaycharity.org/your_url_here"
GOOGLE_LOGIN="your_google_login_for_childsplay_for_childsplay"
GOOGLE_PASSWORD="your_google_password_for_childsplay_authentication"
```
To get a Twitch username, sign up for an account at http://www.twitch.tv

Get your Twitch oauth password via this page: http://twitchapps.com/tmi/

**For Childsplay:**
* Make sure you've created your Childs Play account using your Google login info. Currently, this widget only supports Google logins for Childs Play.
* To get the URL needed for the DONATION_PAGE variable, [sign in with your Google account here](https://sso.childsplaycharity.org/user/login).
* Now, click the "Organizer" link in the navigation bar.
* Finally, click the "Donations" link next to your event's name and copy that page's URL and paste it into the appropriate variable in your .env file.