import datetime
import email
import imaplib
import time

EMAIL_ACCOUNT = "msdtest002@gmail.com"
PASSWORD = "user1234"
# EMAIL_ACCOUNT = "iquicktestsg@gmail.com"
# PASSWORD = "zxb66306691"
mail = imaplib.IMAP4_SSL('imap.gmail.com')

def login_gmail(username, password):
    mail.login(username, password)
    mail.list()
    mail.select('inbox')

def get_security_code():
    security_code = ""
    condition = True
    cur_time = datetime.datetime.now()
    timeout = time.time() + 30

    # wait for receiving new mail
    while condition:
        if time.time() > timeout:
            print('check mail timeout,not received verify code from mail')
            break
        result, data = mail.uid('search', None, "ALL")  # (ALL/UNSEEN)
        # i = len(data[0].split())
        latest_email_uid = data[0].split()[-1]
        result, email_data = mail.uid('fetch', latest_email_uid, '(RFC822)')
        # result, email_data = conn.store(num,'-FLAGS','\\Seen')
        # this might work to set flag to seen, if it doesn't already
        raw_email = email_data[0][1]
        raw_email_string = raw_email.decode('utf-8')
        email_message = email.message_from_string(raw_email_string)

        # Header Details
        date_tuple = email.utils.parsedate_tz(email_message['Date'])
        if date_tuple:
            local_date = datetime.datetime.fromtimestamp(email.utils.mktime_tz(date_tuple))
            if local_date >= cur_time:
                    condition = False
                    break

    # Get title 
    if not condition:
        security_code = email_message['subject'].split()[0]
    print(security_code)
    return security_code

