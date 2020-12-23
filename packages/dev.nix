{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      git                 # version control
      vscode              # code editor
    ];
}
