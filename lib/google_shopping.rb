require 'capybara/dsl'

class GoogleShopping
  include Capybara::DSL

  def initialize
    visit 'https://www.google.co.uk/shopping'
    if !page.has_title? 'Google Shopping'
      fail
    end
  end

  def verify_search(string)
    within 'div.sh-pr__product-results' do
      result = first'div.psli h3'
      if result.text.slice(string).nil?
        fail
      end
    end
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
