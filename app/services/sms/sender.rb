require 'restclient'

module Sms
  class Sender

    def initialize alert
      @alert = alert
    end

    def send_to_users
      users.each do |obj|
        r = pilvo_client.send_message(default_params(obj.mobile_number))
        puts r
      end
    end

    private

    def pilvo_client
      auth_id = "MAN2ZHYZDHMDZIZMRKZD"
      auth_token = "YzllYTIwZjJkMTE0ZGQ2YjI1ZDlhNjAzOTEzODE4"
      @pilvo_client ||= Plivo::RestAPI.new(auth_id, auth_token)
    end

    def default_params mobile_number
      {
        src: '+639052103869',
        dst: local_no(mobile_number),
        text: @alert.event,
        method: "POST"
      }
    end

    def local_no mobile_number
      mobile_number[0] = "+63"
      mobile_number
    end

    def users
      @users ||= UserAlert.full_details(@alert.facility_type,@alert.facility_name)
    end



  end

end
