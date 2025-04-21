session_root "~/rr-job/git/Timerman/"

if initialize_session "rr-timerman"; then
  new_window "code"
  new_window "lazygit"
  new_window "rr-vpn"
  new_window "components"

  select_window "lazygit"
  run_cmd "lazygit"

  select_window "rr-vpn"
  run_cmd "vpn-rr"

  select_window "components"
  run_cmd "cd ../TimerManComponents/ && nvim"

  select_window "code"
  run_cmd "nvim"
fi

finalize_and_go_to_session
