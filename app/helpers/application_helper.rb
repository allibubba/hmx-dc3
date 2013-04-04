module ApplicationHelper
  def request_url
    request.protocol + request.host + ":" + request.port.to_s + request.fullpath
  end

  def locales_enum
    [
      [t('en_US'), "en_US"],
      [t('en_gb'), "en_GB"],
    ]
  end

  def iemobile?
    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(IEMobile)/]
  end


end