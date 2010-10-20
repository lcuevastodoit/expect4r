module Interact
module Router
module Common
module Modes
  def in?(mode=:none)
    login unless connected?
    case mode
    when :exec    ; exec?
    when :shell   ; shell?
    when :config  ; config?
    else
      _mode_?
    end
  end
  def change_mode_to(mode)
    login unless connected?
    case mode
    when :exec    ;  to_exec
    when :shell   ;  to_shell
    when :config  ;  to_config
    end
  end
  def _mode_?
    putline ' ', :no_trim=>true, :no_echo=>true unless @lp
    if exec? 
      :exec
    elsif config?
      :config
    elsif shell?
      :shell
    else
    end
  end
end
end
end
end