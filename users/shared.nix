{ config, pkgs, vars, lib, ... }:
{
  users.users.${vars.user} = {
    uid = 1000;
    isNormalUser = true;
    home = "/home/${vars.user}";
    extraGroups = [
      "wheel" "video" "input" "networkmanager"
    ];
  };

  #systemd.services."home-manager-ugly-hack" = {
  #  script = "mkdir -p /nix/var/nix/profiles/per-user/${vars.user} && chown ${vars.user}:users /nix/var/nix/profiles/per-user/${vars.user}";
  #  path = [ pkgs.coreutils ];
  #  before = [ "home-manager-${vars.user}.service" ];
  #  wantedBy = [ "multi-user.target" ];
  #};

  time.timeZone = "America/Sao_Paulo";

  #home-manager = {
  #  useGlobalPkgs = true;
  #  users.${vars.user} = {
  #    home.file.".icons/default/index.theme".text = ''
  #      [Icon Theme]
  #      Name=Default
  #      Comment=Default Cursor Theme
  #      Inherits=Vanilla-DMZ
  #    '';
  #    home.file.".config/nixpkgs/config.nix".text = ''
  #      { allowUnfree = true; }
  #    '';

  #    home.file.".config/git/config".source = ../users/shared/.config/git/config;
  #    home.file.".config/git/ignore".source = ../users/shared/.config/git/ignore;
  #    home.file.".config/git/user".text = ''
  #      [user]
  #        email = ${vars.email}
  #        name = ${vars.name}
  #    '';

  #    home.file.".config/zathura/zathurarc".source = ../users/shared/.config/zathura/zathurarc;

  #    home.file.".config/roxterm.sourceforge.net/Colours/joker".source = ../users/shared/.config/roxterm.sourceforge.net/Colours/joker;
  #    home.file.".config/roxterm.sourceforge.net/Profiles/Default".source = ../users/shared/.config/roxterm.sourceforge.net/Profiles/Default;
  #    home.file.".config/roxterm.sourceforge.net/Global".source = ../users/shared/.config/roxterm.sourceforge.net/Global;

  #    home.file.".config/alacritty/alacritty.yml".source = lib.mkDefault ../users/shared/.config/alacritty/alacritty.yml;
  #    home.file.".config/alacritty/alacritty-scratchpad.yml".source = lib.mkDefault ../users/shared/.config/alacritty/alacritty-scratchpad.yml;

  #    home.file.".config/mpv/mpv.conf".source = ../users/shared/.config/mpv/mpv.conf;
  #    home.file.".config/mpv/input.conf".source = ../users/shared/.config/mpv/input.conf;

  #    home.file.".eslintrc.json".source = ../users/shared/.eslintrc.json;
  #    home.file.".npmrc".source = ../users/shared/.npmrc;

  #    home.file.".config/astroid/config".source = ../users/shared/.config/astroid/config;
  #    home.file.".config/astroid/poll.sh".source = ../users/shared/.config/astroid/poll.sh;
  #    home.file.".config/astroid/hooks/toggle".source = ../users/shared/.config/astroid/hooks/toggle;
  #    home.file.".config/astroid/keybindings".source = ../users/shared/.config/astroid/keybindings;

  #    home.file.".config/nvim/init.vim".source = ../users/shared/.config/nvim/init.vim;
  #    home.file.".config/nvim/ginit.vim".source = ../users/shared/.config/nvim/init.vim;
  #    home.file.".config/nvim/coc-settings.json".source = ../users/shared/.config/nvim/coc-settings.json;

  #    home.file.".config/fish/config.fish".source = ../users/shared/.config/fish/config.fish;
  #    home.file.".config/fish/functions/fish_prompt.fish".source = ../users/shared/.config/fish/functions/fish_prompt.fish;
  #    home.file.".config/fish/functions/fish_print_git_action.fish".source = ../users/shared/.config/fish/functions/fish_print_git_action.fish;
  #  };
  #};
}
