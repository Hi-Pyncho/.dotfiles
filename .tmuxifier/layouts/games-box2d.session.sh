session_root "~/game-dev/phaser/"

if initialize_session "games-box2d"; then
  new_window "code"
  select_window "code"
  run_cmd "cd ~/game-dev/phaser/games/box2d-learn/"

  new_window "examples"
  select_window "examples"
  run_cmd "cd ~/game-dev/phaser/box2d-examples/"
  run_cmd "pnpm run examples"

  new_window "api"
  select_window "api"
  run_cmd "cd ~/game-dev/phaser/box2d-api/"
  run_cmd "pnpm run docs"

  select_window "code"
fi

finalize_and_go_to_session
