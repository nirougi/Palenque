Palenque
========

This project uses Sinatra and Pi Pipper to manage Raspberry Pi GPIO trough a jSon / jSonP API.

#### Disclaimer
> I'm a designer learning how to code. I know it's not the best code ever, but it's my best. Any help will be welcomed!

> I don't speak english very well too, so do your best to understand it.

Requirements
------------

* Ruby
* Gems: sinatra, thin, pi_piper, sinatra/jsonp

Instalation
-----------

    git clone https://github.com/Jinik/Palenque.git

Usage
-----

    cd Palenque
    rvmsudo ruby palenque.rb

It will be abailable on 

    http://your-ip:4567/{ Key }/{ Module name }/{ Action }/{ Parameters }

* Key: You can change it on /palenque.rb, default is "RASPBERRY4EVERY1"
* Module Name, Action and Parameters: Specific route for each module, you can find them on modules/modole-folder/routes.rb