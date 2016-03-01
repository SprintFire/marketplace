class ConfirmationMailer < ApplicationMailer
  default from: 'do-not-reply@marketplace.com'

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000/login"
    mail(to: @user.email, subject: "Welcome to Marketplace")
  end

  def successfull_shop_creation(shop, user)
    @shop = shop
    @user = user
    @url = "http://localhost:3000/shops/#{shop.id}"
    mail(to: @user.email, subject: "You have created you shop")
  end

  def sold_product_email(product, user)
    @product = product
    @user = user
    mail(to: @user.email, subject: "Your product has been bought")
  end

  def new_review_email(product, review, user)
    @product = product
    @review = review
    @user = user
    mail(to: @user.email, subject: "Your product has gotten a new review")
  end
end
