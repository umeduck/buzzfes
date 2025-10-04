ActiveSupport.on_load(:action_controller) do
  # JSON の自動ラップを無効化
  wrap_parameters format: []
end