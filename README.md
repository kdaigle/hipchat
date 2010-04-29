Hipchat Ruby Library
=====================

This is just the first version of my copy of the HipChat API.  I'm not sure I'm entirely in love with the way it calls Hipchat's API but it assumes a pretty auto-magical format.  The future version may cut that back.

The simple way to use this is as follows:

hipchat = Hipchat::Base.new("yourAPIcode")

rooms = hipchat.rooms

main_room = rooms.first

main_room.speak("Bot Name", "This is a simple message")

users = main_room.users # => Returns a the users in the room

users.first.profile # => Returns the special information about the user