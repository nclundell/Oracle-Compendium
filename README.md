# **Oracle-Compendium**

## Goal

Create a small program that retrieves a list of posts from a compendium feed and displays up to 9 of the most recent matching posts to the user.

Displays:
* Title
* Author Name
* Publish Date
* Post Body

## Requirements
* Ruby
* Nokogiri gem (used for clean parsing of post body html)

## Usage

This is a commandline progam written as a Ruby script.  It requires a valid feed ID and optionally allows any amount of space-deliminated search params.
```
path/to/script/oraclefeed.rb [feed ID] [search_param1 search_param2...]
```
Example:
```
./oraclefeed.rb 78f4b458-2c97-4c9a-bb88-f8124db03b21 frog celsius
```