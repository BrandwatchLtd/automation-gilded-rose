Given /^I am on the google shopping page$/ do
  @shopping_page = GoogleShopping.new
end

And /^I search for "([^"]*)"$/ do |product|
  @shopping_page.search product
end

Then /^I get "([^"]*)" results$/ do |product|
  @shopping_page.verify_search product
end

When /^I click on up to £15$/ do
  @shopping_page.click_up_to_15_pounds
end

Then /^None of the results are more that £15$/ do
  prices = @shopping_page.get_prices.each do |price|
    price = price.text.sub('£', '').to_i
    if price > 15
      fail
    end
  end
end

When /^I click on books$/ do
  @shopping_page.click_on_books_category
end

Then /^the result category is books$/ do
  search = @shopping_page.get_category
  if search.text != 'Books'
    fail
  end
end

When /^I click on the seller "(.+)"$/ do |seller|
  @shopping_page.click_filter_group_entry seller, 'Seller'
end

Then /^the results are for "(.+)"$/ do |seller|
  @shopping_page.verify_shopping seller
end

When /^I click more$/ do
  @shopping_page.click_more
end

When /^I enter £(\d+)$/ do |price|
  @shopping_page.custom_price_range(price)
end

And /^I click go$/ do
  @shopping_page.click_go_on_custom_price_range
end

Then /^the results are all between £20 and £30$/ do |arg|
  pending
end
