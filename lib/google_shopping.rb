require 'capybara/dsl'

SLEEP_PERIOD = 2

class GoogleShopping
  include Capybara::DSL

  def initialize
    visit 'https://www.google.co.uk/shopping'
    if !page.has_title? 'Google Shopping'
      fail
    end
  end

  def search(product_name)
    fill_in 'q', with: product_name
    page.find('#gbqfb').click
    sleep SLEEP_PERIOD
  end

  def verify_search(product_name)
    within 'div.sh-pr__product-results' do
      result = first('div.psli h3').text.downcase
      if !result.include? product_name.downcase
        fail
      end
    end
  end

  def get_prices
    all 'span.price'
  end

  def get_category
    find 'div._Gwj.std'
  end

  # Find the div element for one of the filer groups in the left column
  # of the page.
  #
  # Example colums are Price, Seller, Show price.
  def get_filter_group_by_title(title)
    titles = find_all '.sr__title'
    correct_title = titles.detect {|e| e.text == title}
    # Find the parent group of the correct title
    correct_title.find(:xpath, '..')
  end

  # Click on a filter group item to activate that filter
  def click_filter_group_entry(entry, group)
    group = get_filter_group_by_title(group)
    entry_link = group.find_all('a').detect {|e| e.text == entry}
    entry_link.click
    sleep SLEEP_PERIOD
  end

  def click_more(group='Seller')
    get_filter_group_by_title(group).find('div.sr__link', :text => 'More').click
  end

  def custom_price_range(price)
    within 'form.sr__price-range' do
      if find_field(name: 'lower').value.empty?
        name = 'lower'
      else
        name = 'upper'
      end
      fill_in(:name => name, :with => price)
    end
  end

  def click_go_on_custom_price_range
    within 'form.sr__price-range' do
      find_button(text: 'Go').click
    end
  end

  def click_up_to_15_pounds
    find('span', :text => 'Up to £15').click
    sleep SLEEP_PERIOD
  end

  def click_on_books_category
    find('span[title=Books]').click
    sleep SLEEP_PERIOD
  end

  # Click each result to see the given supplier for the result
  def verify_shopping(seller)
    # For each result click the title link to see more info.
    all('a.pstl').each do |element|
      element.click
      # Get the text from the 'from' line in the info pane and check
      # it's right.
      unless find('span._-dv').text.downcase == seller.downcase
        fail
      end
    end
  end

  # Check the price of every product falls in an inclusive range
  #
  # @param minimum_price [Numeric] Minimum allowable price
  # @param maximum_price [Numeric] Maximum allowable price
  def prices_in_range(minimum_price, maximum_price)
    all('.price').each do |element|
      price = element.text.sub('£', '').to_f
      unless price.between? minimum_price, maximum_price
        fail
      end
    end
  end
end
