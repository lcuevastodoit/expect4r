
require 'router/cisco/common/common'

class Expect4r::Nexus < ::Expect4r::BaseLoginObject

  include Expect4r
  include Expect4r::Router
  include Expect4r::Router::Common
  include Expect4r::Router::Common::Modes
  include Expect4r::Router::CiscoCommon
  include Expect4r::Router::Nexus::Modes
  include Expect4r::Router::CiscoCommon::Show
  include Expect4r::Router::CiscoCommon::Ping

  def initialize(*args)
    super
    @ps1 = /(.*)(>|#|\$)\s*$/
    @more = / --More-- /
  end

  def login(arg={})
    super(spawnee, arg)
    config 'no logging console' if port>0
    exec "terminal len 0\nterminal width 0"
    self
  end
  # FIXME: 1.9.2 bug:
  # It calls LoginBaseOject#login() instead of calling J#login()
  # modified login_by_proxy to call _login_ seems to work.
  alias :_login_ :login

  def putline(line,*args)
    output, rc = super
    raise SyntaxError.new(self.class.to_s, line) if output.join =~ /\% Invalid command at|No token match at|\% Invalid Value at/
    output
  end

  private

  def abort_config
    return unless config?
    putline 'abort' # make sure buffer config is cleaned up.
    nil
  end

  def show_configuration_failed
    putline 'show configuration failed'
  end

end
