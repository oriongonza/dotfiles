{...}: {
  services.tor = {
    enable = true;
    openFirewall = true;
    relay = {
      enable = true;
      role = "relay";
    };
    settings = {
      ORPort = 9001;
      ControlPort = 9051;
      MetricsPort = "127.0.0.1:9052";
      MetricsPortPolicy = "accept 130.0.0.1";
      # BandWidthRate = "1 MBytes";
    };
  };
}
