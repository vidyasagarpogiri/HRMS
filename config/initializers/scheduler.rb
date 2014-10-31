require 'rubygems'
require 'rufus-scheduler'
require 'active_record'

#scheduler = Rufus::Scheduler.new
#singleton @pattabhi
scheduler = Rufus::Scheduler.singleton

scheduler.cron '0 0 7 * *'  do 
   puts "hello"
end

#cron job to do a task in every month day 7 at zero th hour  5th minute (5 min after mid night) 
scheduler.cron '5 0 7 * *'  do 
   puts "hello"
end

# schedular to do job in every 24 hrs
scheduler.every '24h' do
  # do something every 24 hours
end

scheduler.every '10s' do
  puts " hello "
end

