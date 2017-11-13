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
  elements = all 'span.price'
  prices = elements.map { |e| e.text.sub('£', '').to_i }
  prices.each do |price|
    if price > 15
      fail
    end
  end
end

When /^I click on books$/ do
  @page.click_on_books_category
end

Then /^the results are all books$/ do
  search = find 'div._Gwj.std'
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
