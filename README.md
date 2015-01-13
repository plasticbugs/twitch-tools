# Twitch Tools #

This is a small but growing set of on-screen, chromakey-able widgets for Twitch streamers.

Currently Implemented:

## Childs Play Charity Donation Widget ##
A donation widget that scrapes ChildsPlayCharity.org and posts donations on screen as they occur along with the donor's username, message and amount. Donation messages stay on-screen for 30 seconds, then fade away.

## Carnival-style Prize Wheel ##
A prize wheel that pulls in a maximum of 25 randomly selected users from a given Twitch.TV chat room. The user can click the Spin button for each prize to be awarded to lucky viewers.

## URLS: ##
The donation widget currently lives at:
		rooturl/pages

The prize wheel endpoint is:
		rooturl/wheel/[twitch channel name]
		rooturl/wheel/gamesdonequick //for example