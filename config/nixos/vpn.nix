{ ... }:

# Setup VPNs. Each VPN requires a secret file to be placed in the `secrets/` root
# directory.
#
# The OVPN credentials format is
#
# username
# password

let
  vpnFile = name: builtins.toString (./vpn-files + "/${name}");
  secretFile = name: builtins.toString (../../secrets + "/${name}");
  vpnConfig = { name, remote }: {
    config = ''
      client
      remote ${remote} 1194
      dev tun
      proto udp
      port 1194
      cipher bf-cbc
      comp-lzo adaptive
      ca ${vpnFile "ftgp-new-${name}-ca.crt"}
      cert ${vpnFile "ftgp-new-${name}.crt"}
      key ${vpnFile "ftgp-new-${name}.key"}
      auth-user-pass ${secretFile "ftgp-new-${name}-credentials"}
    '';
    autoStart = false;
    updateResolvConf = false;
  };
in {
  services.openvpn.servers = {
    finsit-prod = vpnConfig {
      name = "prod";
      remote = "13.69.8.196";
    };
    finsit-test = vpnConfig {
      name = "test";
      remote = "51.144.36.50";
    };
    finsit-acce = vpnConfig {
      name = "acce";
      remote = "40.68.242.143";
    };
  };
}
