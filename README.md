# MF60 #

The MF60 is a portable, personal WIFI hotspot that is sold worldwide in countries like Australia and Switzerland (where I live). Apparently, over a million of these devices were sold in Australia alone last year.

Like most hotspots, it comes with a pretty pitiful web interface and not much in the way of an API. I commute on the train frequently, and I sometimes find I need to reset the box. I was curious to see if I could somehow automate that a little bit. For instance, I wanted to be able to quickly disconnect/reconnect from the command-line, or maybe gather statistics. So I wrote this library.

This Gem provides a Ruby library that lets you connect to the device and control it:
    
    > require 'MF60'
    > mf60 = MF60::Client.new('admin', 'secret')
    > mf60.reset
    => true
    
You can also get stats:
    
    > mf60.stats
    => {:current_trans=>1133211, :current_recv=>2884959, :connect_time=>"29:33", :total_recv=>222000830}
    
There's a command-line utility installed as well with the gem that makes this easy to do:

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
      
The project is built with [HTTParty](https://github.com/jnunemaker/httparty) and [Thor](https://github.com/wycats/thor). Both libraries are fun and awesome to use.
