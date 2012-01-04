require 'rubygems'
require 'httparty'
require 'mf60/version'
require 'mf60/helpers'

# The MF60 requires some kind of "luck number" with each post, but it does
# not seem to make mich difference what it is. The cookie is required to 
# maintain the session after login.

module MF60
  class Client
    DEVICE_URL = ENV['MF60URL'] || "http://swisscom-mf60.home/"
    
    include HTTParty
    format :html
    
    def initialize(user, pass)
      @lucknum = 123456
      response = self.class.post(
                    DEVICE_URL + '/goform/goform_process',
                    :body => {
                      'user' => user, 
                      'psw' => pass,
                      'goformId'=>'LOGIN',
                      'lucknum'=>@lucknum
                    }
                  )
      @cookie = response.headers['set-cookie']
    end
    
    def get(path)
      response = self.class.get(DEVICE_URL + path, :headers => {'Cookie' => @cookie})
    end

    def connect
      net_connect(true)
    end

    def disconnect
      net_connect(false)
    end

    def reset
      self.disconnect
      sleep 4
      self.connect
    end
    
    def stats
      response = self.get('/adm/statistics.asp')
      info = response.match(/var realtime_statistics = '([\d\,]+)'/)[1]
      stats = info.split(',')
      {
        :current_trans => stats[2].to_i,
        :current_recv  => stats[3].to_i,
        :connect_time  => "%02d:%02d" % [stats[4].to_i/60, stats[4].to_i%60],
        :total_recv   => stats[5].to_i
      }
    end

    def status
      response = self.get('/air_network/wireless_info.asp')
      vars = %w(provider network_type_var cardstate current_network_mode rscp ecio)
      status = {}
      vars.each do |var_name|
        status[var_name.to_sym] = grab_var(response, var_name)
      end
      status
    end
    
    private
    
      # mode: 'connect' or 'disconnect'
      def net_connect(active)
        body = {
          'goformId'=>'NET_CONNECT',
          'lucknum_NET_CONNECT'=>@lucknum
        }
        if active
          body['dial_mode'] = 'auto_dial'
        else
          body['dial_mode'] = 'manual_dial'
          body['action'] = 'disconnect'
        end
        response = self.class.post(DEVICE_URL + '/goform/goform_process', :body => body)
      end

      def grab_var(response, var_name)
        part = response.match(/var\s+#{var_name}\s+=\s+'([^']+)'/)
        part ? part[1] : ''
      end
      
  end
end
