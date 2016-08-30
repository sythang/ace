module ApiHelper
	def json_response
    @json_response ||= JSON.parse(response.body, symbolize_names: true)
  end

  def sign_in account
    {'Http-Auth-Token' => account.api_token}
  end
end