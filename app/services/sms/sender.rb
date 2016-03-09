require 'restclient'

module Sms
  class Sender

    def send


      auth_id = "MAN2ZHYZDHMDZIZMRKZD"
      auth_token = "YzllYTIwZjJkMTE0ZGQ2YjI1ZDlhNjAzOTEzODE4"

      p = Plivo::RestAPI.new(auth_id, auth_token)

      params = {
          'src' => '+639052103869',
          'dst' => '+639276558460', # Receiver's phone Number with country code
          'text' => 'Hi Sir Brian From IISPPT', # Your SMS Text Message - English
          'method' => 'POST' # The method used to call the url
      }
      response = p.send_message(params)
      puts response

    end

  end

end
