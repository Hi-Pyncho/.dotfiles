# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/rr-job/git/RussiaRunningApp/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "rr-new-app"; then

  # Create a new window inline within session layout definition.
  #

  new_window "code"
  new_window "lazygit"
  new_window "rr-vpn"

  select_window "lazygit"
  run_cmd "lazygit"

  select_window "rr-vpn"
  run_cmd "vpn-rr"

  select_window "code"
  run_cmd "nvim"

  # Load a defined window layout.
  #load_window "example"

  # Select the default active window on session creation.
  #select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
