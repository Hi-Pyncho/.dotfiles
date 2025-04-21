session_root "~/rr-job/git/RussiaRunning.Results.Frontend/"

if initialize_session "rr-lk"; then
  new_window "code"
  new_window "lazygit"
  new_window "rr-vpn"

  select_window "lazygit"
  run_cmd "lazygit"

  select_window "rr-vpn"
  run_cmd "vpn-rr"

  select_window "code"
  run_cmd "nvim"
fi

finalize_and_go_to_session
