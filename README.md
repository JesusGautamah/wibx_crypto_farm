# Wibx Crypto Farm
###### Debian º Ruby On Rails º TailWindCSS º Redis º PostgreSQL º Sidekiq º Selenium WebDriver º Tor º Privoxy


<br>

### **This project is for educational purposes only.**
It is not intended to be used for financial gain.

This project contains the source code for Wibx Crypto Farm, which is an application that
uses the Tor Proxy concept with some crawler functions in order to farm wibx cryptocurrencies, taking the results and transforming them into a table for data analysis, where it will be possible to measure the engagement of the crypto gain by the platform.

About the project:

## Dependencies

* Ruby 3.0.1

* Postgresql 14.0

* Sidekiq

* Redis-Server

* Tor

* Privoxy

* EasyProxy ``By JesusGautamah``
https://github.com/JesusGautamah/EasyProxy

### Installation

#### Tor & Privoxy(use socks5t instead of 4a and set cookie auth 0 in torrc config ``/etc/tor/torrc``) 
<br> https://www.amirootyet.com/post/tor-privoxy-kali-debian/

#### Redis & Postgresql
    
    sudo apt-get install redis-server postgresql libpq-dev      

#### Postgresql First Configuration
<br> https://stackoverflow.com/questions/1471571/how-to-configure-postgresql-for-the-first-time
#### run the following commands:

    git clone https://github.com/JesusGautamah/wibx_crypto_farm.git

    cd wibx_crypto_farm
    bundle
    # or
    bundle install
    gem install foreman

### You have to configure your system to accept ``service`` or ``systemctl`` commands without password, search about ``visudo`` documentation for that.
<br>

### To use ``systemctl``, you have to edit the code where it says ``service`` and change it to ``systemctl`` inside ``easypx`` shell script.
<br>

### ``EasyProxy`` Installation (This is a dependency of the project, you can do it in)

#### `` Remember you need to have tor and privoxy installed and configured with tor forwading the default port``
#### `` Remember to configure tor with Cookie Auth 0 ``
    git clone https://github.com/JesusGautamah/EasyProxy.git
    cd EasyProxy
    sudo mv EasyProxy /bin
    sudo chmod +x /bin/EasyProxy
    EasyProxy
### Database Creation

#### Remember to initialize the database
#### Edit the database.yml file in ``/config/database.yml``
#### And run the following commands:

    rake db:create
    rake db:migrate 
    # or
    rake db:setup
### Usage

    foreman start --procfile=Procfile.dev
    # follow the instructions at the first page of the application
    # May the force be with you

All the concept are in the Sidekiq Jobs.
What the code does is use tor and privoxy
to make request agains the wibx products crawled
links by the ``WibxRetrieverJob`` in loop, this is done
by using the ``WibxFarmJob``.

### **``Do Not Use It For Financial Gain``**

##### Developed by ``JesusGautamah`` in 2022 for educational purposes only.
