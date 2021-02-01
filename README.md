# Asterisk queue cleaner
## Asterisk Queue cleaner Ruby script

Sometimes call center agents forget to leave the asterisk queues and incoming calls continue to ring their phones, although no one can answer outside of working hours.

To solve this problem, I made a simple script that can be launched as a Cron task.

Run 'rvm cron setup' then append asterisk crontab running 'crontab -e'

#Sample cron task for asterisk-queue-cleaner at 6pm every day
0 18 * * * /home/asterisk/bin/q-e.rb > /dev/null 2>&1

Apply new cron settings as root or sudo

'service cron restart'

Then you can check new crontab:
'crontab -u asterisk -l'

You should see something like this:

#sm start rvm
PATH="/usr/local/rvm/gems/ruby-2.7.2/bin:/usr/local/rvm/gems/ruby-2.7.2@global/bin:/usr/local/rvm/rubies/ruby-2.7.2/bin:/usr/local/rvm/gems/ruby-2.7.2/bin:/usr/local/rvm/gems/ruby-2.7.2@global/bin:/usr/local/rvm/rubies/ruby-2.7.2/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/usr/local/rvm/bin:/home/asterisk/.local/bin:/home/asterisk/bin"
GEM_HOME='/usr/local/rvm/gems/ruby-2.7.2'
GEM_PATH='/usr/local/rvm/gems/ruby-2.7.2:/usr/local/rvm/gems/ruby-2.7.2@global'
MY_RUBY_HOME='/usr/local/rvm/rubies/ruby-2.7.2'
IRBRC='/usr/local/rvm/rubies/ruby-2.7.2/.irbrc'
RUBY_VERSION='ruby-2.7.2'
#sm end rvm
0 18 * * * /home/asterisk/bin/q-e.rb > /dev/null 2>&1

#other asteisk cron jobs
#...
#...
