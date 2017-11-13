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
