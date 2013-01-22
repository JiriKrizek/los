#!/usr/bin/env ruby
#

require "rubygems"
require "google_drive"
require "json"

# File containing OAuth API info
require './auth'

DOCS_DRIVE_ID='0AkVwi3dFkxT0dFRlaHlDeHZXQkFfRGsxemxXT1BXblE'

client = OAuth2::Client.new(
    Auth::CLIENT_ID, Auth::CLIENT_SECRET,
    :site => "https://accounts.google.com",
    :token_url => "/o/oauth2/token",
    :authorize_url => "/o/oauth2/auth")
auth_url = client.auth_code.authorize_url(
    :redirect_uri => "urn:ietf:wg:oauth:2.0:oob",
    :scope =>
        "https://docs.google.com/feeds/ " +
        "https://docs.googleusercontent.com/ " +
        "https://spreadsheets.google.com/feeds/")

auth_token = OAuth2::AccessToken.from_hash(client,
    {:refresh_token => Auth::REFR, :expires_at => Auth::EXP})
auth_token = auth_token.refresh!


unless auth_token.refresh_token.nil?
  puts "Token refreshed"
  str = "Module Auth"
  str +=  "  REFR=\"#{auth_token.refresh_token}\"\n"
  str +=  "  EXP=\"#{auth_token.expires_at}\"\n"
  str += "end\n"
 
  File.open('./auth.rb', 'w') {|f| f.write(str) }
end

session = GoogleDrive.login_with_oauth(auth_token.token)

ws = session.spreadsheet_by_key(DOCS_DRIVE_ID).worksheets[0]

people = []
for row in 2..24
  r = ws[row, 1]
  people << r unless r.nil? || r.empty?
end

str = "#!/usr/bin/env ruby
# encoding: UTF-8
#
module People
  PEOPLE = {
"
(0..people.size-1).each do |i| 
  ch = 65+i/4 
  num=i%4+1
  str+= "    \"#{ch.chr}#{num}\" => \"#{people[i].ljust(18)}\",\n"
end
 str += "}
end"

puts str

