module Pilvo
  class Sender

    def send


      AUTH_ID = "Your AUTH_ID"
      AUTH_TOKEN = "Your AUTH_TOKEN"

      p = RestAPI.new(AUTH_ID, AUTH_TOKEN)

      params = {
          'src' => '1111111111', # Sender's phone number with country code
          'dst' => '2222222222', # Receiver's phone Number with country code
          'text' => 'Hi, from Plivo', # Your SMS Text Message - English
          'method' => 'POST' # The method used to call the url
      }
      response = p.send_message(params)
      puts response

    end

  end

end
