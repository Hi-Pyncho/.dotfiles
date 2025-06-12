session_root "~/rr-job/git/RussiaRunningApp/"

if initialize_session "rr-new-app"; then
  new_window "code"
  new_window "lazygit"

  select_window "lazygit"
  run_cmd "lazygit"

  select_window "code"
  run_cmd "nvim"
fi

finalize_and_go_to_session
