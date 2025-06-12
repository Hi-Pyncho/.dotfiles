session_root "~/game-dev/phaser/"

if initialize_session "gamedev-phaser"; then
  new_window "code"
  select_window "code"
  run_cmd "cd ~/game-dev/phaser/games/"

  new_window "notes"
  select_window "notes"
  run_cmd "cd ~/game-dev/game-notes/ && nvim"

  new_window "shared"
  select_window "shared"
  run_cmd "cd ~/game-dev/phaser/shared/phaser-shared/ && nvim"

  select_window "code"
fi

finalize_and_go_to_session
