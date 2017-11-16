# automation-gilded-rose
Brandwatch automation tech test

![old Marmite logo][marmite-logo]

## What is this?
I had a few drinks last night.
I needed to create some basic automated tests for ensuring I can always get hold of Marmite.
To be honest I'm not sure what I was thinking, I just really wanted some Marmite.
 
## Installation
To run the tests you need to install Ruby and the Chrome browser and WebDriver

### Chrome and Chrome WebDriver
Download and install Chrome for your platform from [here][chrome-dl], then
install chromedriver by downloading it from [here][chromedriver] and adding
it to your `PATH`. Check that it is available by opening a shell and running,

    $ chromedriver --version

you should see something starting `ChromeDriver 2.33.506092` _[...]_

### Ruby
To get the tests running install [rbenv] and [rbenv-build] for your platform,
remembering to install the right development headers if you are running Linux
(see [here][rbenv-build-instructions]).

Build Ruby 2.4.2 using,

    $ rbenv install 2.4.2

...and get a coffee, because it might take a while.

Navigate to the project root and run,

    $ gem install bundler

then install the rest of the pre-requisites with,

    $ bundle install


## Running the tests
To run the test suit navigate to the project root and run

    $ bundle exec cucumber
 

## What is your fixation with Marmite?
I just like Marmite is all...

[rbenv]: https://github.com/rbenv/rbenv
[rbenv-build]: https://github.com/rbenv/ruby-build
[rbenv-build-instructions]: https://github.com/rbenv/ruby-build/wiki
[chromedriver]: https://sites.google.com/a/chromium.org/chromedriver/
[chrome-dl]: https://www.google.com/chrome/browser/desktop/index.html
[marmite-logo]: https://vignette.wikia.nocookie.net/logopedia/images/4/4b/Marmite.jpg
