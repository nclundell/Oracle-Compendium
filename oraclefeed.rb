#!/usr/bin/env ruby
require 'net/http'
require 'json'
require 'date'
require 'io/console'
require 'nokogiri'
 
url = 'http://app.compendium.com/api/publishers/'

unless ARGV[0]
    abort "Please enter a publisher UUID and try again."
else
    url = url + ARGV[0]+ '/feed'
end

unless ARGV.length == 1
    url = url + "?search_terms="
    ARGV[1..-1].each do |search_term|
        url = url + search_term + " "
    end
end

response = Net::HTTP.get(URI(url))
feed = JSON.parse(response)

if feed.class == Hash && feed['error']
    abort feed['error']
end

feed.sort_by! { |post| post['publish_date'] }
feed.reverse!

feed[0..8].each do |post|
    printf "%-10s %s\n", "Title:", post['title']
    printf "%-10s %s\n", "Author:", post['author']['name']
    printf "%-10s %s\n", "Date:", DateTime.parse(post['publish_date']).strftime("%B %d, %Y at %I:%M %p")
    printf "%-10s %s\n", "Post:", Nokogiri::HTML.parse(JSON.parse(Net::HTTP.get(URI(post['asset_url'])))['body']).text.strip.gsub(/(.{1,#{IO.console.winsize[1]-20}})(\s+|\Z)/, "\\1\n"+" "*11)
    print "\n"
end