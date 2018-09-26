#! /usr/bin/python

import webbrowser

SUBJECT = 'RPG Title Feedback'
MESSAGE = "Hi, I hope you don't mind me sending you a private message."

def launch(url):
    webbrowser.open(url
        + '&subject=' + SUBJECT
        + '&message=' + MESSAGE
    )


#fp = file('reddit_users_general.txt')
fp = file('reddit_users_RPGdesign.txt')
for line in fp:
    launch(line.strip())
