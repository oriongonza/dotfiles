{ config, pkgs, ... }:

{
  networking.wireless.networks = {
    "Redmi Note 11" = { # phone
      psk = "ardipollon";
    };
    "Orion" = { # phone
      psk = "garimbera";
    };
    "DIGIFIBRA-zykS" = { # minerva
      psk = "yQQU3tCsEAzz";
    };
    "DIGIFIBRA-PLUS-zykS" = { 
      psk = "yQQU3tCsEAzz";
    };
    "MiFibra-ADBD_Ext" = {
      psk = "RKhTY3A9";
    };
    "MOVISTAR_PLUS_BFC0" = { # mama
      psk =  "nAF3NH3CP4JMFWWN74Y3";
    };
    "MOVISTAR_BFC0" = { 
      psk =  "nAF3NH3CP4JMFWWN74Y3";
    };
    "MiFibra-1587-5G" = { # Sara pogos
      psk =  "gtWtKwr2";
    };
    "MiFibra-1587" = {
      psk =  "gtWtKwr2";
    };
    "Livebox6-B9F6" = {
      psk =  "V6kP7Cdh5rSV";
    };
  };
  networking.wireless.enable = true;
  networking.networkmanager.enable = false;
  networking.hostName = "nixos";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; 
}
