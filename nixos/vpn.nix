{ ... }: {
  networking.wg-quick.interfaces = let
    server_ip = "185.159.159.17";
  in {
    wg0 = {
      # IP address of this machine in the *tunnel network*
      address = [
        "10.2.0.2/32"
        # "fdc9:281f:04d7:9ee9::2/64"
      ];
      dns = [ "10.2.0.1" ];

      # To match firewall allowedUDPPorts (without this wg uses random port numbers).
      listenPort = 51820;

      # Path to the private key file.
      privateKeyFile = "/home/ardi/dotfiles/nixos/vpn.secret";
      peers = [{
        publicKey = "/azd2IMh4oxqBXidWNQ4e1zDvLsdqtIrjYfiL2FDSzw=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "${server_ip}:51820";
        # persistentKeepalive = 25;
      }];
    };
  };
}
