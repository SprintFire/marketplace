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
            column("User ID") {|user| link_to "##{user.id}", admin_user_path(user)}
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
            column("Shop ID") {|shop| link_to "##{shop.id}", admin_shop_path(shop)}
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
            column("Product ID") {|product| link_to "##{product.id}", admin_product_path(product)}
            column(:name)    {|product| product.name }
            column(:description)    {|product| product.description }
            column(:price) {|product| number_to_currency product.price, unit: "€"}
            column("From Shop") {|product| link_to product.shop.name, admin_shop_path(product.shop) }
            column("Listed at")    {|product| time_ago_in_words(product.created_at) + " ago" }
          end
        end
      end

      column do
        panel "Recent Trades" do
          table_for Purchase.order('id desc').limit(10).each do |purchase|
            column("Purchase ID") {|purchase| link_to "##{purchase.id}", admin_purchase_path(purchase) }
            column(:buyer_email)   {|purchase| link_to purchase.user.email, admin_user_path(purchase.user) }
            column(:product) {|purchase| link_to purchase.product.name, admin_product_path(purchase.product) }
            column("From Shop") {|purchase| link_to purchase.product.shop.name, admin_shop_path(purchase.product.shop) }
            column("Purchased at")    {|purchase| time_ago_in_words(purchase.created_at) + " ago" }
          end
        end
      end # column
    end # columns

    columns do
      column do
        panel "Recent Withdrawal Requests" do
          table_for Withdrawal.order('id desc').limit(10).each do |withdrawal|
            column("Withdrawal ID") {|withdrawal| link_to "##{withdrawal.id}", admin_withdrawal_path(withdrawal)}
            column("From Shop") {|withdrawal| link_to withdrawal.shop.name, admin_shop_path(withdrawal.shop)}
            column("Amount") {|withdrawal| number_to_currency number_with_precision(shop_balance_in_euros(withdrawal.amount), precision: 2),unit: "€"}
            column("Status") {|withdrawal| withdrawal.approved ? "Approved" : "Pending"}
            column("Created at") {|withdrawal| time_ago_in_words(withdrawal.created_at) + " ago"}
          end
        end
      end # column

      column do
        panel "Pending Withdrawals" do
          table_for Withdrawal.pending.each do |withdrawal|
            column("Withdrawal ID") {|withdrawal| link_to "##{withdrawal.id}", admin_withdrawal_path(withdrawal)}
            column("From Shop") {|withdrawal| link_to withdrawal.shop.name, admin_shop_path(withdrawal.shop)}
            column("Amount") {|withdrawal| number_to_currency number_with_precision(shop_balance_in_euros(withdrawal.amount), precision: 2),unit: "€"}
            column("Created at") {|withdrawal| time_ago_in_words(withdrawal.created_at) + " ago"}
          end
        end
      end # column
    end # columns
  end # content
end
