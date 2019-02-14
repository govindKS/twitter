class GoogleCalendarWrapper
	attr_accessor :user


	def initialize(user)
    configure_client(user)
  end
	def configure_client(user)
		client_id, client_secret = ['814784756236-icdtg1am6iuqu77dpm5rc2fqve2q5noe.apps.googleusercontent.com', 'HYWv9MV2UAK-HET9er4mGJ56']
		@client = Google::APIClient.new(application_name: "ticketsmplycalender")
		account_email = "govind@ticketsmplycalender.iam.gserviceaccount.com"
		key_file = 'ticketsmplycalender-7efd0990aa56.p12'
		key_secret = 'notasecret'
		key = Google::APIClient::KeyUtils.load_from_pkcs12(key_file, key_secret)
		@client.authorization = Signet::OAuth2::Client.new(
															:token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
															:audience => 'https://accounts.google.com/o/oauth2/token',
															:scope => 'https://www.googleapis.com/auth/calendar',
															:issuer => account_email,
															:signing_key => key
														)
		@client.authorization.fetch_access_token!
		@client.authorization.client_id = client_id
		@client.authorization.client_secret = client_secret
		@client.authorization.authorization_uri = 'https://accounts.google.com/o/oauth2/auth'
    @client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
		@client.user_agent = ""
		@service = @client.discovered_api('calendar', 'v3')
	end

	def insert_event
		# event = {
		# 					summary: "Board of Directors Meeting", 
		# 					location: "Conference Room - 1",
		# 					start: {dateTime: '2019-03-20T12:04:00+0000'},  
		# 					end: {dateTime: '2019-03-21T12:04:00+0000'},  
		# 					description: "important meeting with the board",
		# 					attendees: [ { "email" => 'govind.k@bitlasoft.com' },{ "email" =>'govind.mietcse@gmail.com' } ] 
		# 				}

		event = {
							summary: "Board of Directors Meeting", 
							location: "Conference Room - 1",
							start: {dateTime: '2019-03-20T12:04:00+0000'},  
							end: {dateTime: '2019-03-21T12:04:00+0000'},  
							description: "important meeting with the board",
							attendees: [ { "email" => 'govind.mietcse@gmail.com' }] 
						}
		@client.execute(:api_method => @service.events.insert,
											:parameters => {
												'calendarId' => "govind@ticketsmplycalender.iam.gserviceaccount.com",
												'sendNotifications' => true,
												'singleEvents'=> true,
												'timeMin' => 'today'},
												:body => JSON.dump(event),
												:headers => {'Content-Type' => 'application/json'}
										)
	end
end