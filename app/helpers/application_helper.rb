module ApplicationHelper
  def shop_balance_in_euros(balance_in_cents)
    balance_in_cents / 100.00
  end


  # Pages active class helpers

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def is_active(controller, action)
    action?(action) && controller?(controller) ? 'active' : nil
  end

  def is_controller(controller)
    controller?(controller) ? 'active' : nil
  end
end
