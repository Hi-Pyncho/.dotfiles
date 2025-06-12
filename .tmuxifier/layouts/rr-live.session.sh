session_root "~/rr-job/git/RussiaRunning/"

if initialize_session "rr-lk"; then
  new_window "code"
  new_window "lazygit"

  select_window "lazygit"
  run_cmd "lazygit"

  select_window "code"
  run_cmd "cd ~/rr-job/git/RussiaRunning/src/Web/RussiaRunning.Web.Chrono/Content/live-vue/"
  run_cmd "nvim"
fi

finalize_and_go_to_session
