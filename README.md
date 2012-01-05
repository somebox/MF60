# MF60 #

The MF60 is a portable, personal WIFI hotspot that is sold worldwide in countries like Australia and Switzerland (where I live). Apparently, over a million of these devices were sold in Australia alone last year.

![my mf60](http://dl.dropbox.com/u/385855/mf60.jpg)

# Installation #


    $ gem install mf60
    $ mf60 --help

Like most hotspots, it comes with a pretty pitiful web interface and not much in the way of an API. I commute on the train frequently, and I sometimes find I need to reset the box. I was curious to see if I could somehow automate that a little bit. For instance, I wanted to be able to quickly disconnect/reconnect from the command-line, or maybe gather statistics. So I wrote this library.

_Note: When you are logged into the admin interface from a browser, you will be logged out as soon as you connect with this library. That's just the way it goes._

The Swisscom MF60 from ZTE is known to work with this, but other carriers and devices may be compatible. Let me know.

## Library ##

By default, the library attempts to connect to the device's web admin interface at http://192.168.0.1/. You can change the address with an environment variable,`MF60URL`:

    $ export MF60URL="http://swisscom-mf60.home"
    
    or, in an app:
    
    # ENV['MF60URL'] = "http://192.168.1.1"

There's just one class to use, `MF60::Client`:
    
    > require 'MF60'
    > mf60 = MF60::Client.new('admin', 'secret')
    > mf60.reset
    => true
    
Statistics and status are returned as a hash:
    
    > mf60.stats
    => {:current_trans=>1133211, :current_recv=>2884959, :connect_time=>"29:33", :total_recv=>222000830}

See the [command-line utility source](https://github.com/somebox/MF60/blob/master/bin/mf60) for descriptions of the keys.


## Command-line Utility ##    
    
A command-line utility gets installed with the gem, called `mf60`. Before using it, set the admin interface password via an environment variable:

    $ export MF60PW="secret"

    or
    
    $ MF60PW="secret" mf60 status

There are just a few tasks supported for now:

    $ mf60
    Tasks:
      mf60 connect      # Connect to the cellular network
      mf60 disconnect   # Disconnect from the cellular network
      mf60 help [TASK]  # Describe available tasks or one specific task
      mf60 reset        # Reset the WAN connection
      mf60 stats        # Get statistics and usage info
      mf60 status       # Display connection status and signal strength
      
Tracking signal strength can be interesting as well:

      $ mf60 status
      MF60 Current Status
      -------------------
      Provider     : Swisscom
      Network Type : UMTS
      Device State : modem_init_complete
      rscp/ecio    : 176/16
      rssi         : 11
      signal       : ▁ ▂ ▃......

The signal meter is probably not that accurate (needs tweaking) and doesn't work at all when on GPRS (2G).

## Code   
      
There's no official published protocol for this device that I know of. Firebug and Firefox were used to inspect and reverse engineer the web admin interface of the device.

I hope to soon write a stats-gathering script so I can graph signal strength along different train lines.

The project is built with [HTTParty](https://github.com/jnunemaker/httparty) and [Thor](https://github.com/wycats/thor). Both libraries were fun and awesome to use.
