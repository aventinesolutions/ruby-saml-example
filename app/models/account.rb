class Account < ActiveRecord::Base
  def self.get_saml_settings(url_base)
    # this is just for testing purposes.
    # should retrieve SAML-settings based on subdomain, IP-address, NameID or similar
    settings = OneLogin::RubySaml::Settings.new

    url_base ||= "http://localhost:3003"

    # Example settings data, replace this values!

    # When disabled, saml validation errors will raise an exception.
    settings.soft = true

    #SP section
    settings.issuer                         = url_base + "/saml/metadata"
    settings.assertion_consumer_service_url = url_base + "/saml/acs"
    settings.assertion_consumer_logout_service_url = url_base + "/saml/logout"

    # IdP section
    settings.idp_entity_id                  = 'https://app.onelogin.com/saml/metadata/501136'
    settings.idp_sso_target_url             = 'https://reelmetrics.onelogin.com/trust/saml2/http-post/sso/501136'
    settings.idp_slo_target_url             = 'https://reelmetrics.onelogin.com/trust/saml2/http-redirect/slo/501136'
    settings.idp_cert                       =
'    -----BEGIN CERTIFICATE-----
MIIEIDCCAwigAwIBAgIURkAf7e/p6iWHlheRmP0ThvoUQpgwDQYJKoZIhvcNAQEF
BQAwWzELMAkGA1UEBhMCVVMxFDASBgNVBAoMC1JlZWxNZXRyaWNzMRUwEwYDVQQL
DAxPbmVMb2dpbiBJZFAxHzAdBgNVBAMMFk9uZUxvZ2luIEFjY291bnQgNzI3ODgw
HhcNMTUxMTIzMTYwNTQ4WhcNMjAxMTI0MTYwNTQ4WjBbMQswCQYDVQQGEwJVUzEU
MBIGA1UECgwLUmVlbE1ldHJpY3MxFTATBgNVBAsMDE9uZUxvZ2luIElkUDEfMB0G
A1UEAwwWT25lTG9naW4gQWNjb3VudCA3Mjc4ODCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMhLnDz5sHVi3prLRowTHOrreIjvrDLZg71zX7gcvtk15jW9
bPyEYazODO1dAgtxaOXNUvVTfI6IleEPFfqiiRZD9aNFx6t1SWbZWbTO3NRzQZnD
+MuB9r3toPLDJecKFUa86vGGLSrPaZukTjcU7S6bHC3swXf+hvHU02H5KykwKQDJ
fsLycJrdaVhy2wiiKwJNuMpmxTB3rzqJe20mcsC902PbZjsscc0YEWxGxQfFiyLj
dTeb2pepBBSxUGrBuR1X1KUPFZSTTTJZYc1PLqpAE1KSIMildGzr0vyQbtXk19oZ
Vt9xDDtIXrX5LMOgk6X9Hrctzm41IukMoneB1j8CAwEAAaOB2zCB2DAMBgNVHRMB
Af8EAjAAMB0GA1UdDgQWBBRTzVAIIYYRdeX6lwt48GxxRns2XDCBmAYDVR0jBIGQ
MIGNgBRTzVAIIYYRdeX6lwt48GxxRns2XKFfpF0wWzELMAkGA1UEBhMCVVMxFDAS
BgNVBAoMC1JlZWxNZXRyaWNzMRUwEwYDVQQLDAxPbmVMb2dpbiBJZFAxHzAdBgNV
BAMMFk9uZUxvZ2luIEFjY291bnQgNzI3ODiCFEZAH+3v6eolh5YXkZj9E4b6FEKY
MA4GA1UdDwEB/wQEAwIHgDANBgkqhkiG9w0BAQUFAAOCAQEApKl0AbKWIBws7O+Z
hL1c6qxBwwmKSV9jCP9TGmO95yOdJwgrEflZg648kWivvosCFXY6xy1gFhpTIlla
2Gsr5OJ/F3T2eN6Qz1JFbKIqDvK2y7W6IC4b6AhteuckZxG1qUxYXzhHx+Y2YiC6
RTm2BX+n0w4L6AbdhUNDMcgH+ur7S+GrZPPuqU1VBfBaRel5M5RgIwdupuflnPJn
//X53hfEnJohiEskxS2W23RPBMeqSY5FpRc+twp8AdD4gLpbtJX6RdQfa1lz/t30
ixTsMC+pQ2My5Ekn+lNypmFs9SSQiPG8ZSyoLn+3PoeHlAVDBE5h7w8nSbOd1yPQ
VyhqJg==
    -----END CERTIFICATE-----'

    # or settings.idp_cert_fingerprint           = "3B:05:BE:0A:EC:84:CC:D4:75:97:B3:A2:22:AC:56:21:44:EF:59:E6"
    #    settings.idp_cert_fingerprint_algorithm = XMLSecurity::Document::SHA1

    settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

    # Security section
    settings.security[:authn_requests_signed] = false
    settings.security[:logout_requests_signed] = false
    settings.security[:logout_responses_signed] = false
    settings.security[:metadata_signed] = false
    settings.security[:digest_method] = XMLSecurity::Document::SHA1
    settings.security[:signature_method] = XMLSecurity::Document::RSA_SHA1

    settings
  end
end
