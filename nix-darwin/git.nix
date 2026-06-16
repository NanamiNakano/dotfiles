{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git-interactive-rebase-tool
  ];

  programs.delta.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    signing = {
      format = "ssh";
      signByDefault = true;
    };
    settings = [
      {
        init.defaultBranch = "main";
        pull.rebase = true;
        diff.colorMoved = "default";

        core = {
          autocrlf = "input";
          pager = "delta";
        };
        sequence.editor = "interactive-rebase-tool";
        interactive.diffFilter = "delta --color-only";
        merge.conflictstyle = "diff3";
        delta = {
          navigate = true;
          dark = true;
          line-numbers = true;
        };
        fetch.parallel = 0;
      }
      {
        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com/";
          };
        };
      }
    ];
    includes = [
      {
        path = "~/dotfiles/.gitconfig.private";
      }
    ];
  };
}
