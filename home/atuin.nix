{
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      theme = {
        name = "autumn";
      };
      sync = {
        records = true;
      };
    };
    enableZshIntegration = true;
  };
}
