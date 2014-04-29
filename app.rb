require 'faraday'
require 'json'
require 'launchy'

puts "Hi there! What subreddit would you like to check?  Example:  For r/tampa, simply type 'tampa' "
sub = gets.chomp!.to_s.downcase

puts "Getting you the top posts for /r/#{sub}."
puts ""

response = Faraday.get "http://www.reddit.com/r/#{sub}.json"
json_response = JSON.parse response.body

posts = json_response['data']['children']

i = 1

posts.take(10).each do |p|
  post = p['data']

  puts "#{i}. " + post['title']
  puts "Ups: #{post['ups']} | Downs: #{post['downs']} | Score: #{post['score']}"
  puts ''
  i += 1
end

puts "Would you like to open any of these?  Choose the number to open, or reply 'No'"
open_url = gets.chomp!.to_s
if open_url.downcase == "no" or open_url.to_i > 10
  puts "ok"
else
  Launchy.open posts[open_url.to_i - 1]['data']['url']
end
