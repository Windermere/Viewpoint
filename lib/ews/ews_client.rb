require 'ews/folder_accessors'
require 'ews/item_accessors'
require 'ews/message_accessors'
require 'ews/mailbox_accessors'

# This class is the glue between the Models and the Web Service.
class Viewpoint::EWSClient
  include Viewpoint::EWS
  include Viewpoint::EWS::Types
  include Viewpoint::EWS::FolderAccessors
  include Viewpoint::EWS::ItemAccessors
  include Viewpoint::EWS::MessageAccessors
  include Viewpoint::EWS::MailboxAccessors

  # The instance of Viewpoint::EWS::SOAP::ExchangeWebService 
  attr_reader :ews

  # Initialize the EWSClient instance.
  # @param [String] endpoint The EWS endpoint we will be connecting to
  # @param [String] user The user to authenticate as. If you are using
  #   NTLM or Negotiate authentication you do not need to pass this parameter.
  # @param [String] pass The user password. If you are using NTLM or
  #   Negotiate authentication you do not need to pass this parameter.
  # @param [Hash] opts Various options to pass to the backends
  # @option opts [String] :server_version The Exchange server version to
  #   target. See the VERSION_* constants in
  #   Viewpoint::EWS::SOAP::ExchangeWebService.
  def initialize(endpoint, user = nil, pass = nil, opts = {})
    con = Connection.new(endpoint)
    con.set_auth(user,pass) if(user && pass)
    @ews = SOAP::ExchangeWebService.new(con, opts)
  end
end
