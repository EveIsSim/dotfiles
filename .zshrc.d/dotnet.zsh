dtt() {
  DOTNET_SYSTEM_CONSOLE_ALLOW_ANSI_COLOR_REDIRECTION=1 \
  dotnet test --logger "console;verbosity=detailed" "$@"
}
