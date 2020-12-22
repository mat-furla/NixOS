{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      nodejs_latest       # node development
      git                 # version control
      vscode              # code editor
    ];
}
