ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Admin Notes" do
          para "Welcome to the Marketplace Admin page. Here you can find some useful statistic intelligence of the Marketplace."
        end
      end
    end

    columns do
      column do
        panel "Recent Registered Users" do
          table_for User.order('id desc').limit(10).each do |user|
            column(:first_name)    {|user| user.first_name }
            column(:last_name)    {|user| user.last_name }
            column(:email)    {|user| user.email }
            column(:created_at)    {|user| time_ago_in_words(user.created_at) + " ago" }
          end
        end
      end

      column do
        panel "Recent Created Shops" do
          table_for Shop.order('id desc').limit(10).each do |shop|
            column(:name)    {|shop| shop.name }
            column(:description)    {|shop| shop.description }
            column(:created_at)    {|shop| time_ago_in_words(shop.created_at) + " ago" }
          end
        end
      end
    end

    columns do
      column do
        panel "Recent Listed Products" do
          table_for Product.order('id desc').limit(10).each do |product|
            column(:name)    {|product| product.name }
            column(:description)    {|product| product.description }
            column(:price) {|product| number_to_currency product.price}
            column("From Shop") {|product| product.shop.name }
            column("Listed at")    {|product| time_ago_in_words(product.created_at) + " ago" }
          end
        end
      end

      column do
        panel "Recent Trades" do
          table_for Purchase.order('id desc').limit(10).each do |purchase|
            column(:buyer_email)   {|purchase| purchase.user.email }
            column(:product) {|purchase| purchase.product.name }
            column("From Shop") {|purchase| purchase.product.shop.name }
            column("Purchased at")    {|purchase| time_ago_in_words(purchase.created_at) + " ago" }
          end
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
