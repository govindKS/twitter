require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'date'
require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Google Calendar API Ruby Quickstart'.freeze
CREDENTIALS_PATH = 'credentials.json'.freeze
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
TOKEN_PATH = 'token.yaml'.freeze
SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts 'Open the following URL in the browser and enter the ' \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end

# Initialize the API
service = Google::Apis::CalendarV3::CalendarService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

# Fetch the next 10 events for the user
calendar_id = 'primary'
response = service.list_events(calendar_id,
                               max_results: 10,
                               single_events: true,
                               order_by: 'startTime',
                               time_min: DateTime.now.rfc3339)
puts 'Upcoming events:'
puts 'No upcoming events found' if response.items.empty?
response.items.each do |event|
  start = event.start.date || event.start.date_time
  puts "- #{event.summary} (#{start})"
end


def abc

    # ical = Icalendar::Calendar.new
    # e = Icalendar::Event.new
    # binding.pry
    # binding.pry
    # e.start = DateTime.now.utc
    # e.start.icalendar_tzid="UTC" # set timezone as "UTC"
    # e.end = (DateTime.now + 1.day).utc
    # e.end.icalendar_tzid="UTC"
    # e.organizer "any_email@example.com"
    # e.uid "MeetingRequest#sdfdsf"
    # e.summary "Scrum Meeting"
    # ical.add_event(e)
    # ical.publish


    ical = Icalendar::Calendar.new
  #   ical.event do |e|
  #     e.dtstart     = Date.today+1
  #     e.dtend       = Date.today+2
  #     e.summary     = "Meeting with the man."
  #     e.description = "Have a long lunch meeting and decide nothing..."
  #     e.ip_class    = "PRIVATE"
  #   end

  # ical.publish


  event = Icalendar::Event.new
event.dtstart = DateTime.civil(2019, 2, 17, 8, 30)
event.summary = "A great event!"
ical.add_event(event)

event2 = ical.event  # This automatically adds the event to the calendar
event2.dtstart = DateTime.civil(2019, 2, 18, 8, 30)
event2.summary = "Another great event!"
ical.publish
  # Add the .ics as an attachment
  attachments['event.ics'] = { mime_type: 'application/ics', content: ical.to_ical }

  mail(from: "govind.k@bitlasoft.com", to: "govind.mietcse@gmail.com", subject: "Appointment")
  # mail(from: "govind.k@bitlasoft.com", to: "govind.mietcse@gmail.com", subject: "Appointment") do |format|
  #   format.ics {
  #     ical = Icalendar::Calendar.new
  #     e = Icalendar::Event.new
  #     binding.pry
  #     # e.start = DateTime.now.utc
  #     # e.start.icalendar_tzid="UTC" # set timezone as "UTC"
  #     # e.end = (DateTime.now + 1.day).utc
  #     # e.end.icalendar_tzid="UTC"
  #     # e.organizer "any_email@example.com"
  #     # e.uid "MeetingRequest#sdfdsf"
  #     # e.summary "Scrum Meeting"
  #     ical.add_event(e)
  #     ical.publish
  #     ical.to_ical
  #     render :text => ical.to_ical
  #   }
  # end
end