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

When /^I click on Ocado$/ do
  find(:xpath, '//*[@id="leftnavc"]/div/div[5]/div[2]/div[4]/a').click
  sleep 2
end

Then /^the results are for Ocado$/ do
  @page.verify_shopping 'Ocado'
end

When /^I click more$/ do
  pending
end

And /^I click on Eat big$/ do
  pending
end

Then /^the results are for Eat big$/ do
  pending
end

When /^I enter £20$/ do
  pending
end

And /^I enter £30$/ do
  pending
end

And /^I click go$/ do
  pending
end

Then /^the results are all between £20 and £30$/ do |arg|
  pending
end
