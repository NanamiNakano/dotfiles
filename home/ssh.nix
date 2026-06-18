{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        IdentityAgent = "~/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
        PreferredAuthentications = "publickey,gssapi-with-mic,hostbased,keyboard-interactive,password";
        PasswordAuthentication = "no";
      };

      "github.com" = {
        Hostname = "ssh.github.com";
        Port = 443;
        User = "git";
      };
    };
  };
}
