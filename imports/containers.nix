{ config, pkgs, lib, ...}:

with lib;

let
  mkContainer = import ./containers/default.nix {
    inherit config pkgs lib;
  };

  gorigorOpts = rec {
    address = "192.168.11.22";

    rootPathPrefix = "/var/www/totalassessment/dashboard";

    vhosts = {
      "ta-dash-drupal.local" = {
        default = true;
        root = "${rootPathPrefix}/drupal";
      };

      "ta-dash-laravel.local" = {
        default = false;
        root = "${rootPathPrefix}/laravel/public";
      };
    };

    mounts = {
      "/var/www/totalassessment" = {
        hostPath = "/home/krofek/projects/totalassessment";
        isReadOnly = false;
      };

      "/home/webserv/hostDownloads" = {
        hostPath = "/home/krofek/Downloads";
        isReadOnly = false;
      };
    };
  };

  growlyOpts = {
    address = "192.168.66.66";
    vhosts = {
      "growly.local" = {
        default = true;
        root = "/var/www/growly/public";
      };
    };
    mounts = {
      "/var/www/growly" = {
        hostPath = "/home/krofek/projects/growly";
        isReadOnly = false;
      };
    };
    redis = true;
    # elasticsearch = true;
  };

  dpsOpts = {
    address = "192.168.22.22";
    vhosts = {
      "dps.local" = {
        default = true;
        root = "/var/www/dps/public";
      };
    };
    mounts = {
      "/var/www/dps" = {
        hostPath = "/home/krofek/projects/dps";
        isReadOnly = false;
      };
    };
    redis = true;
    elasticsearch = true;
  };

in

# containers settings
{
  /*"gorigor" = mkContainer "gorigor.local" gorigorOpts;*/
  "growly"  = mkContainer "growly.local" growlyOpts;
  "dps" = mkContainer "dps.local" dpsOpts;
}
