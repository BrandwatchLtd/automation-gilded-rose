require 'capybara/dsl'

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
    sleep 1
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
    sleep 2
  end

  def click_more(group='Seller')
    get_filter_group_by_title(group).find('div.sr__link', :text => 'More').click
  end

  def click_up_to_15_pounds
    find('span', :text => 'Up to £15').click
    sleep 2
  end

  def click_on_books_category
    find('span[title=Books]').click
    sleep 2
  end

  def verify_shopping(string)
    elements = all 'div.pslline'
    case "string"
    when 'ocado'
      elements.each do |element|
        unless element.text =~ /Ocado/
          fail
        end
      end
    end
  end
end
