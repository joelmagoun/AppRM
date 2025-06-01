class AzureB2CConfig {
  static const clientID = "bcc3bf7a-a732-4750-a444-468986574241";
  static const redirectURL = 'msauth.vc.rms.demorm://auth';
  static const userFlowName = "B2C_1_RMSVC";
  static const scopes = ['openid', 'offline_access'];
  static const userAuthFlow =
      "https://rmsvc.b2clogin.com/rmsvc.onmicrosoft.com";
  static const tenantName = "rmsvc";
}
